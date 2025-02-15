-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- UI config
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 5 --Move screen up and do>
vim.opt.scrolloff = 5
vim.opt.whichwrap = "b,s,<,>,h,l"
vim.opt.swapfile = false --Inhibit the use of swapfile.
vim.opt.list = true
vim.opt.colorcolumn = "79"
vim.opt.listchars = {
  tab = "▷ ",
  trail = "·",
  -- extends = "◣",
  -- precedes = "◢",
  nbsp = "○",
}
vim.opt.timeoutlen = 1000 -- Changed LazyVim default as whichkey not used.
--LSP settings
vim.lsp.inlay_hint.enable(false) -- Disable inline diagnostics.
-- Setting to activarte deep-ocean material theme.
vim.g.material_style = "deep ocean" --Setting desired style
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals,skiprtp,folds" --for auto-session.
--Inserting configuration for terminal mode
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
local hardmode = true
if hardmode then
  -- Show an error message if a disabled key is pressed
  local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

  -- Disable arrow keys in insert mode with a styled message
  vim.api.nvim_set_keymap("i", "<Up>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Down>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Left>", "<C-o>" .. msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("i", "<Right>", "<C-o>" .. msg, { noremap = true, silent = false })
end
