return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
      close_if_last_window = true,
    },
  }
}
