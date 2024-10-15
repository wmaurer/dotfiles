local lazypath = vim.fn.stdpath("data") .. "/lazy-vscode/lazy.nvim"
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

-- https://www.lazyvim.org/extras/vscode
require("lazy").setup({
	"monaqa/dial.nvim",
	"ggandor/flit.nvim",
	"folke/lazy.nvim",
	"ggandor/leap.nvim",
	"echasnovski/mini.ai",
	"echasnovski/mini.comment",
	"echasnovski/mini.move",
	"echasnovski/mini.pairs",
	"echasnovski/mini.surround",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"tpope/vim-repeat",
	"gbprod/yanky.nvim"
})

require('leap').create_default_mappings()
require('mini.move').setup()
require('mini.surround').setup()
require("yanky").setup({
	highlight = {
    		on_put = false,
    		on_yank = false,
  	}
})

--
-- vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
-- vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutBefore)")
-- vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
-- vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
--
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
--
-- vim.keymap.set("n", "]p", "<Plug>(YankyGPutBefore)")
-- vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
-- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
-- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
--
-- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
-- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
-- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
-- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
--
-- vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
-- vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
--
--
-- vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
-- vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
--
