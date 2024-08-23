local g = vim.g
local opt = vim.opt

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.conceallevel = 1

opt.encoding = "UTF-8"

--- Bufferline
vim.opt.termguicolors = true

---
--- General
---
opt.mouse = "a"			-- Enable mouse support
opt.clipboard = "unnamedplus" 	-- Copy/paste to system clipboard
opt.swapfile = false 		-- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" 	-- Don't use swapfile

---
--- Author
---
g.header__field__author = "Marc Vincent Bentoy"
g.header__field__author_email = "marc.bentoy@gmail.com"
g.header__field__modified_by = 0
g.header__field__timestamp_format = "%b %d, %Y"

---
--- Neovim UI
---
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.foldmethod = "marker"
opt.splitright = true
opt.splitbelow = true
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = true
opt.termguicolors = true
opt.laststatus = 3
opt.cursorline = true

---
--- Tabs, indent
---
opt.expandtab = true 	-- Use spaces instead of tabs
opt.shiftwidth = 4 	-- Shift 4 spaces when tabbed
opt.tabstop = 4 	-- 1 tab == 4 spaces
opt.softtabstop = 4 	-- Tab key delete 4 spaces
opt.smartindent = true 	-- Auto indent new lines

---
--- Memory/CPU
---
opt.hidden = true 	-- Enable background buffers
opt.history = 100 	-- Remember n lines of history
opt.lazyredraw = true 	-- Faster scrolling
opt.updatetime = 700 	-- ms to wait to trigger an event

---
--- Nerd Commenter
---
-- Adds a space after comment
g.NERDSpaceDelims = 1 	
-- Adds a space after comment
g.NERDTrimTrailingWhitespace = 1 	


---
--- Startup
---
-- Disable nvim intro
opt.shortmess:append("sI")

-- Disable builtin plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
