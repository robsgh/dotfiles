local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_boostrap = ensure_packer()

vim.cmd([[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = { 'neovim/nvim-lspconfig', 'nvim-lua/plenary.nvim' },
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.diagnostics.eslint,
                    null_ls.builtins.diagnostics.mypy,
                    null_ls.builtins.diagnostics.pycodestyle,
                    null_ls.builtins.diagnostics.pydocstyle,
                    null_ls.builtins.completion.spell,
                },
            })
        end,
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<cr>', {})
            require('nvim-tree').setup({})
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'p00f/nvim-ts-rainbow',
        },
        run = ':TSUpdate',
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({ check_ts = true })
        end,
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/lsp-status.nvim' },
        config = function()
            require('lualine').setup({
                options = { theme = 'sonokai' },
                sections = {
                    lualine_x = { require('lsp-status').status, 'encoding', 'fileformat', 'filetype' },
                },
            })
        end,
    }

    use {
        'kylechui/nvim-surround',
        tag = '*',
        config = function()
            require('nvim-surround').setup({})
        end,
    }

    use {
        'sainnhe/sonokai',
    }



    if packer_bootstrap then
        require('packer').sync()
    end
end)
