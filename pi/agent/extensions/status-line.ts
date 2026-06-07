/**
 * Powerline Status Extension
 *
 * Replaces pi's footer with a Neovim-style powerline that shows agent state,
 * preset/status extensions, model, thinking level, git branch, cwd, tool count,
 * context usage, token totals, and cost.
 */

import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";
import { basename } from "node:path";

type Theme = ExtensionContext["ui"]["theme"];
type FgColor = Parameters<Theme["fg"]>[0];
type BgColor = Parameters<Theme["bg"]>[0];
type ThinkingLevel = "off" | "minimal" | "low" | "medium" | "high" | "xhigh";

interface Segment {
  id: string;
  text: string;
  fg: FgColor;
  bg: BgColor;
}

const LEFT_SEPARATOR = "";
const RIGHT_SEPARATOR = "";
const RESET_FG = "\x1b[39m";
const RESET_BG = "\x1b[49m";
const ANSI_PATTERN = /\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~]|\][^\x07]*(?:\x07|\x1B\\))/g;
const SPINNER_FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

function stripAnsi(value: string): string {
  return value.replace(ANSI_PATTERN, "");
}

function fmtNumber(value: number): string {
  if (!Number.isFinite(value)) return "0";
  if (Math.abs(value) < 1000) return value.toFixed(0);
  if (Math.abs(value) < 1_000_000) return `${(value / 1000).toFixed(1)}k`;
  return `${(value / 1_000_000).toFixed(1)}m`;
}

function fmtCost(value: number): string {
  if (!Number.isFinite(value) || value <= 0) return "$0";
  if (value < 0.01) return `$${value.toFixed(4)}`;
  if (value < 1) return `$${value.toFixed(3)}`;
  return `$${value.toFixed(2)}`;
}

function formatCwd(cwd: string): string {
  return basename(cwd) || cwd;
}

function formatModel(ctx: ExtensionContext): string {
  if (!ctx.model) return "no model";
  const provider = "provider" in ctx.model ? ctx.model.provider : undefined;
  return provider ? `${provider}/${ctx.model.id}` : ctx.model.id;
}

function formatContext(ctx: ExtensionContext): string {
  const usage = ctx.getContextUsage();
  const contextWindow = usage?.contextWindow ?? ctx.model?.contextWindow;

  if (!usage || !contextWindow || typeof usage.percent !== "number") {
    return "ctx ?";
  }

  return `ctx ${Math.round(usage.percent)}%/${fmtNumber(contextWindow)}`;
}

function formatThinkingColor(level: string): FgColor {
  const colors: Record<ThinkingLevel, FgColor> = {
    off: "thinkingOff",
    minimal: "thinkingMinimal",
    low: "thinkingLow",
    medium: "thinkingMedium",
    high: "thinkingHigh",
    xhigh: "thinkingXhigh",
  };

  return colors[level as ThinkingLevel] ?? "accent";
}

function getTokenTotals(ctx: ExtensionContext): { input: number; output: number; cost: number } {
  let input = 0;
  let output = 0;
  let cost = 0;

  for (const entry of ctx.sessionManager.getBranch()) {
    if (entry.type !== "message" || entry.message.role !== "assistant") continue;

    const usage = entry.message.usage;
    input += usage?.input ?? 0;
    output += usage?.output ?? 0;
    cost += usage?.cost?.total ?? 0;
  }

  return { input, output, cost };
}

function bgAsFgAnsi(theme: Theme, bg: BgColor): string {
  const ansi = theme.getBgAnsi(bg);
  if (ansi === RESET_BG) return RESET_FG;
  return ansi.replace("\x1b[48;", "\x1b[38;");
}

function renderSeparator(theme: Theme, glyph: string, fgBg: BgColor, bgBg?: BgColor): string {
  const bg = bgBg ? theme.getBgAnsi(bgBg) : "";
  const resetBg = bgBg ? RESET_BG : "";
  return `${bg}${bgAsFgAnsi(theme, fgBg)}${glyph}${RESET_FG}${resetBg}`;
}

function renderLeftSegment(theme: Theme, segment: Segment, nextSegment?: Segment): string {
  const body = theme.bg(segment.bg, theme.fg(segment.fg, ` ${segment.text} `));
  const separator = nextSegment ? renderSeparator(theme, LEFT_SEPARATOR, segment.bg, nextSegment.bg) : "";
  return body + separator;
}

function renderRightSegment(theme: Theme, segment: Segment, previousSegment?: Segment): string {
  const separator = renderSeparator(theme, RIGHT_SEPARATOR, segment.bg, previousSegment?.bg);
  const body = theme.bg(segment.bg, theme.fg(segment.fg, ` ${segment.text} `));
  return separator + body;
}

function renderLeft(theme: Theme, segments: Segment[]): string {
  return segments.map((segment, index) => renderLeftSegment(theme, segment, segments[index + 1])).join("");
}

function renderRight(theme: Theme, segments: Segment[]): string {
  return segments.map((segment, index) => renderRightSegment(theme, segment, segments[index - 1])).join("");
}

function removeSegment(segments: Segment[], id: string): boolean {
  const index = segments.findIndex((segment) => segment.id === id);
  if (index === -1) return false;
  segments.splice(index, 1);
  return true;
}

function getExternalStatusSegments(theme: Theme, footerData: { getExtensionStatuses(): ReadonlyMap<string, string> }): Segment[] {
  const statuses = Array.from(footerData.getExtensionStatuses().entries())
    .filter(([key]) => key !== "status-demo")
    .map(([key, value]) => {
      const clean = stripAnsi(value).trim();
      if (key === "preset" && clean.startsWith("preset:")) {
        return `preset ${clean.slice("preset:".length)}`;
      }
      return clean ? `${key} ${clean}` : key;
    })
    .filter((value) => value.length > 0)
    .slice(0, 2);

  return statuses.map((text, index) => ({
    id: `status-${index}`,
    text,
    fg: "accent",
    bg: "selectedBg",
  }));
}

export default function (pi: ExtensionAPI) {
  let turnCount = 0;
  let isWorking = false;
  let activeToolCount = 0;
  let lastTool: string | undefined;
  let spinnerIndex = 0;
  let spinnerTimer: ReturnType<typeof setInterval> | undefined;
  let requestRender: (() => void) | undefined;

  const refresh = () => requestRender?.();

  const stopSpinner = () => {
    if (!spinnerTimer) return;
    clearInterval(spinnerTimer);
    spinnerTimer = undefined;
  };

  const startSpinner = () => {
    stopSpinner();
    spinnerTimer = setInterval(() => {
      spinnerIndex = (spinnerIndex + 1) % SPINNER_FRAMES.length;
      refresh();
    }, 90);
  };

  const buildStatusSegment = (): Segment => {
    if (activeToolCount > 0) {
      const suffix = activeToolCount > 1 ? `+${activeToolCount - 1}` : "";
      return {
        id: "state",
        text: `${SPINNER_FRAMES[spinnerIndex]} tool ${lastTool ?? "running"}${suffix}`,
        fg: "warning",
        bg: "toolPendingBg",
      };
    }

    if (isWorking) {
      return {
        id: "state",
        text: `${SPINNER_FRAMES[spinnerIndex]} turn ${turnCount}`,
        fg: "accent",
        bg: "selectedBg",
      };
    }

    return {
      id: "state",
      text: "✓ ready",
      fg: "success",
      bg: "toolSuccessBg",
    };
  };

  const installFooter = (ctx: ExtensionContext) => {
    ctx.ui.setStatus("status-demo", undefined);

    ctx.ui.setFooter((tui, theme, footerData) => {
      requestRender = () => tui.requestRender();
      const unsubscribeBranch = footerData.onBranchChange(() => tui.requestRender());

      return {
        dispose() {
          unsubscribeBranch();
          if (requestRender) requestRender = undefined;
        },
        invalidate() {},
        render(width: number): string[] {
          const thinkingLevel = pi.getThinkingLevel();
          const totals = getTokenTotals(ctx);
          const branch = footerData.getGitBranch();
          const activeTools = pi.getActiveTools().length;
          const totalTools = pi.getAllTools().length;

          const leftSegments: Segment[] = [
            buildStatusSegment(),
            ...getExternalStatusSegments(theme, footerData),
            {
              id: "model",
              text: truncateToWidth(formatModel(ctx), 42, "…"),
              fg: "text",
              bg: "userMessageBg",
            },
            {
              id: "thinking",
              text: `think ${thinkingLevel}`,
              fg: formatThinkingColor(thinkingLevel),
              bg: "selectedBg",
            },
          ];

          const rightSegments: Segment[] = [
            {
              id: "cwd",
              text: formatCwd(ctx.cwd),
              fg: "dim",
              bg: "customMessageBg",
            },
            ...(branch
              ? [{ id: "branch", text: ` ${branch}`, fg: "accent" as FgColor, bg: "customMessageBg" as BgColor }]
              : []),
            {
              id: "tools",
              text: `tools ${activeTools}/${totalTools}`,
              fg: "muted",
              bg: "selectedBg",
            },
            {
              id: "context",
              text: formatContext(ctx),
              fg: "warning",
              bg: "toolPendingBg",
            },
            {
              id: "tokens",
              text: `↑${fmtNumber(totals.input)} ↓${fmtNumber(totals.output)}`,
              fg: "muted",
              bg: "selectedBg",
            },
            {
              id: "cost",
              text: fmtCost(totals.cost),
              fg: "success",
              bg: "toolSuccessBg",
            },
          ];

          const dropOrder = [
            ["right", "cwd"],
            ["right", "cost"],
            ["right", "tokens"],
            ["right", "tools"],
            ["left", "status-1"],
            ["left", "status-0"],
            ["right", "branch"],
            ["right", "context"],
            ["left", "thinking"],
            ["left", "model"],
          ] as const;

          for (const [side, id] of dropOrder) {
            const left = renderLeft(theme, leftSegments);
            const right = renderRight(theme, rightSegments);
            if (visibleWidth(left) + visibleWidth(right) + 1 <= width) break;
            removeSegment(side === "left" ? leftSegments : rightSegments, id);
          }

          let left = renderLeft(theme, leftSegments);
          let right = renderRight(theme, rightSegments);

          if (visibleWidth(left) + visibleWidth(right) + 1 > width) {
            const rightWidth = Math.min(visibleWidth(right), Math.max(0, width - 12));
            right = truncateToWidth(right, rightWidth, "");
            left = truncateToWidth(left, Math.max(0, width - visibleWidth(right) - 1), "");
          }

          const padding = " ".repeat(Math.max(1, width - visibleWidth(left) - visibleWidth(right)));
          return [truncateToWidth(left + padding + right, width, "")];
        },
      };
    });
  };

  pi.on("session_start", async (_event, ctx) => {
    turnCount = 0;
    isWorking = false;
    activeToolCount = 0;
    lastTool = undefined;
    installFooter(ctx);
  });

  pi.on("agent_start", async () => {
    isWorking = true;
    startSpinner();
    refresh();
  });

  pi.on("turn_start", async () => {
    turnCount++;
    activeToolCount = 0;
    lastTool = undefined;
    refresh();
  });

  pi.on("tool_execution_start", async (event) => {
    activeToolCount++;
    lastTool = event.toolName;
    refresh();
  });

  pi.on("tool_execution_end", async () => {
    activeToolCount = Math.max(0, activeToolCount - 1);
    refresh();
  });

  pi.on("agent_end", async () => {
    isWorking = false;
    activeToolCount = 0;
    lastTool = undefined;
    stopSpinner();
    refresh();
  });

  pi.on("model_select", async () => refresh());
  pi.on("thinking_level_select", async () => refresh());

  pi.on("session_shutdown", async (_event, ctx) => {
    stopSpinner();
    requestRender = undefined;
    ctx.ui.setFooter(undefined);
  });
}
