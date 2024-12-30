return {
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
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
        "react",
        "regex",
        "rust",
        "swift",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.formatting.black" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "rust-analyzer",
        "flake8",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
}
