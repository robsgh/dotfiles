#!/usr/bin/env python3

from datetime import datetime


# Path to the colorscheme to use as a template
XRESOURCES_COLORSCHEME_PATH: str = "./themes/rob.Xresources"

# Keys which are not part of the color pallete, mapped to their Ghostty key name
GHOSTTY_NON_PALLETE_KEYS = {
    "cursorColor": "cursor-color",
    "foreground": "foreground",
    "background": "background",
}


def has_file_changed(old_content: str, new_content: str) -> bool:
    comment_characters = ["#", "!"]
    old_lines = old_content.split("\n")
    new_lines = new_content.split("\n")

    for i in range(min(len(old_lines), len(new_lines))):
        if not old_lines[i]:
            if not new_lines[i]:
                continue
            else:
                return True
        if old_lines[i][0] in comment_characters:
            continue

        if old_lines[i] != new_lines[i]:
            return True

    return False


def parse_xresources_template(filename: str) -> dict[str, str]:
    """Parse an Xresources file and return it as a dict of key/color_number to hex value with #"""
    colorscheme = {}

    with open(filename) as f:
        for line in f.readlines():
            # ignore comments
            if line.startswith("!"):
                continue

            if line.startswith("*.color"):
                color_number = line.removeprefix("*.color").split(":")[0].strip()
                assert 0 <= int(color_number) < 16
                color_value = line.split("#")[1].strip()
                colorscheme[color_number] = f"#{color_value}"
            elif line.startswith("*."):
                color_type = line.removeprefix("*.").split(":")[0].strip()
                assert color_type in GHOSTTY_NON_PALLETE_KEYS
                color_value = line.split("#")[1].strip()
                colorscheme[color_type] = f"#{color_value}"

    print(f"Parsed colorscheme: {colorscheme}")
    return colorscheme


def create_ghostty_colorscheme(colorscheme: dict[str, str]) -> str:
    timestamp = datetime.now()

    output = f"""# Configuration generated by materialize_colorscheme.py at {timestamp}
# Please use dotfiles/materialize_colorscheme.py to regenerate this file.
"""
    for key, value in colorscheme.items():
        if key in GHOSTTY_NON_PALLETE_KEYS:
            key = GHOSTTY_NON_PALLETE_KEYS[key]
            # ghostty non-palette keys do not have a # prefixed for hex values
            value = value.strip("#")
            output += f"\n{key} = {value}\n"
        else:
            output += f"\npalette = {key}={value}\n"

    return output


def run() -> None:
    import os

    colorscheme_path = os.path.abspath(XRESOURCES_COLORSCHEME_PATH)
    print(f"RUN: Using cwd as path for colorscheme: {colorscheme_path}")
    colorscheme = parse_xresources_template(colorscheme_path)

    print("RUN: Generating ghostty theme from colorscheme...")
    ghostty = create_ghostty_colorscheme(colorscheme)

    if os.path.exists("./ghostty/themes/rob"):
        with open(os.path.abspath("./ghostty/themes/rob"), "r") as gtheme:
            current = gtheme.read()
    else:
        current = ""

    if has_file_changed(current, ghostty):
        with open(os.path.abspath("./ghostty/themes/rob"), "w") as gtheme:
            gtheme.write(ghostty)
        print("RUN: Wrote Ghostty theme file")
    else:
        print("RUN: No change to Ghostty theme file")


if __name__ == "__main__":
    run()
