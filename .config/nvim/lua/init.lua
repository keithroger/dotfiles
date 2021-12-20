-- make everything in one file for now and split it up when its done
-- stuff to add:
    -- debugger
    -- galaxy line

-- map keys function
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- key bindings
vim.g.mapleader = ' '

-- plugs
require 'paq' {
    'savq/paq-nvim';

    'neovim/nvim-lspconfig'; -- lsp
    'hrsh7th/nvim-compe'; -- completion

    'nvim-lua/popup.nvim'; -- dependency
    'nvim-lua/plenary.nvim'; -- dependency
    'nvim-telescope/telescope.nvim'; -- fuzzy finder

    'jghauser/kitty-runner.nvim'; -- repl

    'folke/tokyonight.nvim'; -- colorscheme

    'kevinhwang91/rnvimr'; -- ranger

    'windwp/nvim-autopairs'; -- autoclose ({'""'})

    'farfanoide/vim-kivy'; -- kv file systax highlighting

    'iamcco/markdown-preview.nvim'; -- markdown preview

    'karb94/neoscroll.nvim'; -- smooth scrolling

    'norcalli/nvim-colorizer.lua'; -- hex colors
}


-- lsp
local lsp = require('lspconfig')
lsp.pylsp.setup{}
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<leader>c', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')

-- nvim-compe
vim.o.completeopt = "menuone,noselect"
-- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
map('i', '<CR>',
    'compe#confirm("<CR>")',
    {expr=true, silent=true})
require'compe'.setup {
    enabled = true,
    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        nvim_lua = true;
        calc = false;
        treesiter = false;
    };
}

-- telescope
map('n', '<leader>f', '<cmd> lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown({}))<cr>')
map('n', '<leader>g', '<cmd> lua require("telescope.builtin").live_grep(require("telescope.themes").get_dropdown({}))<cr>')
-- all refs
map('n', '<leader>a', '<cmd> lua require("telescope.builtin").lsp_references(require("telescope.themes").get_dropdown({}))<cr>')
-- suggestion
map('n',  '<leader>s', '<cmd> lua require("telescope.builtin").lsp_workspace_diagnostics(require("telescope.themes").get_dropdown({}))<cr>')

-- tokyonight
vim.cmd 'colorscheme tokyonight'

-- rnvimr
vim.g.rnvimr_enable_picker = 1
-- map('n', '<leader>f', '<cmd>RnvimrToggle<CR>')

-- nvim-autopairs
-- require('nvim-autopairs').setup({
--        map_cr = true; -- map <CR> on insert mode
--         map_complete = true -- insert '(' after selecting fuction or method
-- })
require('nvim-autopairs').setup()

-- markdown-preview.nvim
vim.g.mkdp_auto_start = 1

-- neoscroll.nvim
require('neoscroll').setup()

-- nvim-colorizer
require('colorizer').setup()
