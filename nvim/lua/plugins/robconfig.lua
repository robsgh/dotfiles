return {
  {
    "tokyonight.nvim",
    opts = {
      style = "night",
    },
  },
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^5",
  --   lazy = false,
  -- },
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "swift",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
