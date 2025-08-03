return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 400,
      icons = {
        mappings = true,
        keys = {},
        spec = {
          { '<leader>s', group = '[S]earch' },
          { '<leader>u', group = '[U]I' },
          { '<leader>c', group = '[C]ode' },
          { '<leader>gr', group = 'LSP' },
        },
      },
    },
  },
}
