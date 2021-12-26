-- make everything in one file for now and split it up when its done

-- map keys function
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.cmd[[packadd packer.nvim]]


require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'folke/tokyonight.nvim'

    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'windwp/nvim-autopairs'

    use 'farfanoide/vim-kivy'

    use 'karb94/neoscroll.nvim'
end)

vim.g.mapleader = ' '

-- lsp
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>c', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')


-- lsp
local servers = { 'gopls', 'golangci_lint_ls', 'pylsp'}
for _, lsp in ipairs(servers) do
  require'lspconfig'[lsp].setup {
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- nvim-compe
vim.o.completeopt = "menuone,noselect"

-- cmp
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<tab>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer'}
    })
})

-- telescope
map('n', '<leader>f', '<cmd> lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>')
map('n', '<leader>g', '<cmd> lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<cr>')
-- all refs
map('n', '<leader>a', '<cmd> lua require("telescope.builtin").lsp_references(require("telescope.themes").get_dropdown({}))<cr>')
-- suggestion
map('n',  '<leader>s', '<cmd> lua require("telescope.builtin").diagnostics(require("telescope.themes").get_dropdown({}))<cr>')

-- tokyonight
vim.cmd 'colorscheme tokyonight'

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
require('nvim-autopairs').setup()


-- neoscroll.nvim
require('neoscroll').setup()

-- lualine
require('lualine').setup {
    options = {
        icons_enable = false,
        theme = 'tokyonight',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
    }
}
