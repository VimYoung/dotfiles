require("config.options")
local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/lewis6991/pckr.nvim",
			pckr_path,
		})
	end
	vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

local border_vertical = "║"
local border_horizontal = "═"
local border_topleft = "╔"
local border_topright = "╗"
local border_botleft = "╚"
local border_botright = "╝"
local border_juncleft = "╠"
local border_juncright = "╣"

local api = vim.api
local validate = vim.validate
vim.lsp.util.fancy_floating_markdown = function(contents, opts)
	validate({
		contents = { contents, "t" },
		opts = { opts, "t", true },
	})
	opts = opts or {}

	--split lines that are too long
	local columns = api.nvim_get_option("columns")
	local popup_max_width = math.floor(columns - (columns * 2 / 10))
	local stripped_max_width = {}

	for i, line in ipairs(contents) do
		line = line:gsub("\r", "")
		local len = line:len()
		-- skip adding double empty lines
		if len == 0 and i < #contents and contents[i + 1]:len() == 0 then
		elseif len > popup_max_width then
			for j = 1, math.ceil(len / popup_max_width) do
				table.insert(
					stripped_max_width,
					string.sub(line, 1 + ((j - 1) * popup_max_width), 1 + (j * popup_max_width))
				)
			end
		else
			table.insert(stripped_max_width, line)
		end
	end

	contents = stripped_max_width

	local stripped = {}
	local highlights = {}
	do
		local i = 1
		while i <= #contents do
			local line = contents[i]
			-- TODO(ashkan): use a more strict regex for filetype?
			local ft = line:match("^```([a-zA-Z0-9_]*)$")
			-- local ft = line:match("^```(.*)$")
			-- TODO(ashkan): validate the filetype here.
			if ft then
				local start = #stripped
				i = i + 1
				while i <= #contents do
					line = contents[i]
					if line == "```" then
						i = i + 1
						break
					end
					table.insert(stripped, line)
					i = i + 1
				end
				table.insert(highlights, {
					ft = ft,
					start = start + 1,
					finish = #stripped + 1 - 1,
				})
			else
				table.insert(stripped, line)
				i = i + 1
			end
		end
	end
	-- Clean up and add padding
	stripped = vim.lsp.util._trim_and_pad(stripped, opts)

	local max_length = 0
	for _, line in ipairs(stripped) do
		local len = line:len()
		if len > max_length then
			max_length = len
		end
	end

	-- pad lines with spaces so they are all the same length
	for i, line in ipairs(stripped) do
		line = line:gsub("\r", "")
		-- these have double width or something
		line = line:gsub("—", "-")
		line = line:gsub("–", "-")
		line = line:gsub("·", ".")
		local len = line:len()
		stripped[i] =
			string.format("%s%s%s%s", border_vertical, line, string.rep(" ", max_length - len), border_vertical)
	end

	-- Compute size of float needed to show (wrapped) lines
	opts.wrap_at = opts.wrap_at or (vim.wo["wrap"] and api.nvim_win_get_width(0))
	local width, height = vim.lsp.util._make_floating_popup_size(stripped, opts)

	-- Insert blank line separator after code block
	local insert_separator = opts.separator
	if insert_separator == nil then
		insert_separator = true
	end
	if insert_separator then
		for i, h in ipairs(highlights) do
			h.start = h.start + i - 1
			h.finish = h.finish + i - 1
			if h.finish + 1 <= #stripped then
				table.insert(
					stripped,
					h.finish + 1,
					border_juncleft
						.. string.rep(border_horizontal, math.min(width - 2, (opts.wrap_at or width) - 2))
						.. border_juncright
				)
				height = height + 1
			end
		end
	end

	-- add borders
	table.insert(
		stripped,
		1,
		border_topleft
			.. string.rep(border_horizontal, math.min(width - 2, (opts.wrap_at or width) - 2))
			.. border_topright
	)
	table.insert(
		stripped,
		border_botleft
			.. string.rep(border_horizontal, math.min(width - 2, (opts.wrap_at or width) - 2))
			.. border_botright
	)
	height = height + 2

	-- Make the floating window.
	local bufnr = api.nvim_create_buf(false, true)
	local winnr = api.nvim_open_win(bufnr, false, vim.lsp.util.make_floating_popup_options(width, height, opts))
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, stripped)
	api.nvim_buf_set_option(bufnr, "modifiable", false)

	-- Switch to the floating window to apply the syntax highlighting.
	-- This is because the syntax command doesn't accept a target.
	local cwin = vim.api.nvim_get_current_win()
	vim.api.nvim_set_current_win(winnr)

	vim.cmd("ownsyntax markdown")
	local idx = 1
	--@private
	local function apply_syntax_to_region(ft, start, finish)
		if ft == "" then
			return
		end
		local name = ft .. idx
		idx = idx + 1
		local lang = "@" .. ft:upper()
		-- TODO(ashkan): better validation before this.
		if not pcall(vim.cmd, string.format("syntax include %s syntax/%s.vim", lang, ft)) then
			return
		end
		vim.cmd(
			string.format("syntax region %s start=+\\%%%dl+ end=+\\%%%dl+ contains=%s", name, start, finish + 1, lang)
		)
	end
	-- Previous highlight region.
	-- TODO(ashkan): this wasn't working for some reason, but I would like to
	-- make sure that regions between code blocks are definitely markdown.
	-- local ph = {start = 0; finish = 1;}
	for _, h in ipairs(highlights) do
		-- apply_syntax_to_region('markdown', ph.finish, h.start)
		apply_syntax_to_region(h.ft, h.start, h.finish)
		-- ph = h
	end

	vim.api.nvim_set_current_win(cwin)
	return bufnr, winnr
end

require("pckr").setup({
	display = {
		open_fn = function()
			return require("pckr.util").float({ border = "single" })
		end,
		prompt_border = "double",
	},
})
require("pckr").add({
	{
		"marko-cerovac/material.nvim",
		config = function()
			require("plugins.colorscheme")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("plugins.lualine")
		end,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("plugins.illuminate")
		end,
	},
	{ "sitiom/nvim-numbertoggle" },
	"lewis6991/gitsigns.nvim",
})
