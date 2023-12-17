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

if vim.g.vscode then
    vim.keymap.set('n', '<space>', ':call VSCodeNotify("vspacecode.space")<CR>')
else
    vim.o.tabstop = 4
    vim.o.shiftwidth = 4
    vim.o.smarttab = true
    vim.o.expandtab = true
end

