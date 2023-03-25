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

    -- Color scheme
    use 'sainnhe/sonokai'

    -- File Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<cr>', {})
            require('nvim-tree').setup({})
        end,
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/playground',
            'p00f/nvim-ts-rainbow',
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "wgsl", "rust", "toml", "bash", "cpp", "c", "python" },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                ident = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            })
        end,
        run = ':TSUpdateSync',
    }

    -- Floating terminal within nvim
    use "voldikss/vim-floaterm"

    -- Figure out what the hell is what
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    }

    -- Programming QoL
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    }
    use {
        'kylechui/nvim-surround',
        config = function()
            require("nvim-surround").setup({})
        end,
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-path' ,
            'hrsh7th/cmp-buffer', 
            'hrsh7th/vim-vsnip',
        },
    }

    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({ check_ts = true })
        end,
    }

    use {
        'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require("trouble").setup({})
        end,
    }

    use {
        'kosayoda/nvim-lightbulb',
        requires = { 'antoinemadec/FixCursorHold.nvim' },
        config = function()
            require('nvim-lightbulb').setup({autocmd = {enabled = true}})
        end,
    }

    use {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    }

    use {
        'simrat39/rust-tools.nvim',
        requires = {
            'neovim/nvim-lspconfig',
        },
        config = function()
            local rt = require("rust-tools")
            rt.setup({
              server = {
                on_attach = function(_, bufnr)
                  -- Hover actions
                  vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                  -- Code action groups
                  vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
                settings = {
                    ["rust-analyzer"] = {
                        checkOnSave = {
                            command = "clippy",
                        },
                    },
                },
              },
            })
        end,
    }

    -- A wee bit of pizaz
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

    if packer_bootstrap then
        require('packer').sync()
    end
end)

