return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = function()
      local TS = require 'nvim-treesitter'
      if not TS.get_installed then
        LazyVim.error 'Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.'
        return
      end
      -- make sure we're using the latest treesitter util
      package.loaded['lazyvim.util.treesitter'] = nil
      LazyVim.treesitter.build(function()
        TS.update(nil, { summary = true })
      end)
    end,
    cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },
    branch = 'main',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'dot',
        'gitcommit',
        'gitignore',
        'go',
        'html',
        'javascript',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'proto',
        'python',
        'query',
        'rust',
        'vim',
        'vimdoc',
        'zig',
      },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
