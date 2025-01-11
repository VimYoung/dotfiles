vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" }
--vim.opt.mouse = 'a' 		    --allow the mouse to be used in Neovim

-- Tab
vim.opt.tabstop = 4 -- number of visual spaces per TAB
vim.opt.softtabstop = 4 -- number of spacesin tab when editing
vim.opt.shiftwidth = 4 -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true -- show absolute number
--vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
vim.opt.wrap = false -- Doesn't wraap the line in next line if excedding.
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5 --Move screen up and down when 5 lines are left.
vim.opt.scrolloff = 5 --Move screen up and down when 5 lines are left.
vim.opt.whichwrap = "b,s,<,>,h,l"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Searching
vim.opt.incsearch = true -- search as characters are entered
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered

--General Settings.
vim.o.swapfile = false --Inhibit the use of swapfile.
-- --vim.opt.nocompatible = true         --disable compatibility to old-time.
-- vim.rocks.hererocks = false
-- vim.rocks.enabled = true

-- Auto command to enter terminal mode when entering a terminal buffer
function _G.check_terminal()
	if vim.bo.buftype == "terminal" then
		vim.cmd("startinsert")
	end
end
vim.cmd("autocmd BufEnter * lua check_terminal()")
-- close number if buffertype is terminal.
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

-- Automatically open nvim-tree when opening a file or directory
-- vim.cmd([[
--     augroup OpenNvimTree
--         autocmd!
--         autocmd VimEnter * lua OpenNvimTreeIfPathProvided()
--     augroup END
-- ]])

-- Lua function to open nvim-tree if a path is provided
-- function OpenNvimTreeIfPathProvided()
--     local argv = vim.fn.argv()
--     if #argv > 0 then
--         require('nvim-tree.api').tree.open()
--         -- Switch to the window with the file
--         vim.cmd('wincmd p')
--     end
-- end

-- Close nvim-tree if it's the last window
vim.cmd([[
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
vim.g.mapleader = " " --Set space to leader key.
-- For auto session below settings.
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- For UFO below
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
