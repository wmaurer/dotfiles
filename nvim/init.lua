local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "tpope/vim-surround",
    "tpope/vim-repeat",
    "tpope/vim-unimpaired",
    "unblevable/quick-scope",
    "smoka7/hop.nvim"
})

require'hop'.setup()


vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_set_keymap('n', '0', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '^', '0', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', 'p', '"_dP', { noremap = true, silent = true })

if vim.g.vscode then
    vim.keymap.set('n', '<space>', ':call VSCodeNotify("vspacecode.space")<CR>')
    local function set_hl(group, tbl)
        vim.api.nvim_set_hl(0, group, type(tbl) == 'table' and tbl or { fg = tbl })
    end

    set_hl('HopNextKey', { fg = '#ffffff', bg = '#ff007c', bold = true, italic = false })
    set_hl('HopNextKey1', { fg = '#ffffff', bg = '#f76707', bold = true, italic = false })
    set_hl('HopNextKey2', { fg = '#ffffff', bg = '#e67700', bold = true, italic = false })
    set_hl('HopUnmatched', { fg = '#666666', sp = '#666666' })
else
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.smarttab = true
    vim.o.expandtab = true
end

