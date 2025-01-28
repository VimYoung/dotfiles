-- define common options
local opts = {
	noremap = true, -- non-recursive
	silent = true, -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

--------------------
--My defined keymaps
--------------------
-- Function to check if the current buffer is a terminal and enter Terminal mode if it is
-- Move to the next tab
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<Tab>", [[<C-\><C-n>:tabnext<CR>]], { noremap = true, silent = true })

-- Move to the previous tab
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<S-Tab>", [[<C-\><C-n>:tabprevious<CR>]], { noremap = true, silent = true })

-- Map <leader>r to reload init.lua
vim.keymap.set("n", "<leader>r", ":luafile ~/.config/nvim-pckr/init.lua<CR>", { noremap = true, silent = true })

----
-- Keymaps by plugins
----
-- (For UFO)Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- The above keymaps for ufo are defined in its config file only.
