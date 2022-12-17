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

    -- File Explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<cr>', {})
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
                ensure_installed = { "lua", "rust", "toml", "bash", "cpp", "c", "python" },
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
        run = ':TSUpdate',
    }

    -- Programming QoL
    use 'kylechui/nvim-surround'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'sainnhe/sonokai'
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
    	"simrat39/rust-tools.nvim",
        requires = { 'neovim/nvim-lspconfig' },
        config = function()
            require("rust-tools").setup({})
        end,
    }

    use {
        "mfussenegger/nvim-dap",
        requires = { 'nvim-lua/plenary.nvim' },
    }

    use {
        'folke/trouble.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require("trouble").setup({})
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
        "voldikss/vim-floaterm",
        config = function()
            vim.keymap.set("n", "<Leader>ft", ":FloatermNew --name=floater --height=0.87 --width=0.87 --autoclose=2 zsh <CR> ")
            vim.keymap.set("n", "<Leader>t", ":FloatermToggle floater<CR>")
            vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q<CR>")
        end,
    }


    if packer_bootstrap then
        require('packer').sync()
    end
end)

