local map = require("utils.keymaps")

vim.g.mapleader = " " 

map("n", "<leader>e", ":NvimTreeOpen<CR>", { desc = "Open Nvim Tree" })
map("n", "<leader>ss", ":wa<CR>", { desc = "Save file" })

-- Close buffer and window
map("n", "<leader>qq", ":bd<CR>", { desc = "Close buffer and window" })

-- Clear search highlighting
map("n", "<leader>sq", ":nohl<CR>", { desc = "Clear search highlighting" })

-- Reload configuration without restart nvim
map("n", "<leader>r", ":so %<CR>")

-- Window splits
map("n", "<leader>ww", "<C-w>w")
map("n", "<leader>wh", ":wincmd h<CR>", { desc = "Jump to left window" })
map("n", "<leader>wj", ":wincmd j<CR>", { desc = "Jump to down window" })
map("n", "<leader>wk", ":wincmd k<CR>", { desc = "Jump to up window" })
map("n", "<leader>wl", ":wincmd l<CR>", { desc = "Jump to right window" })

for i = 1, 9, 1 do
	-- Move between windows by leader + window number
	map("n", "<leader>" .. i, ":" .. i .. "wincmd w<CR>")
	-- Close a window by leader + d + window number
	map("n", "<leader>d" .. i, ":" .. i .. "wincmd c<CR>")
end

map("n", "=", "<cmd>vertical resize +5<cr>", { desc = "Make window wider (horizontally)" }) -- make the window biger vertically
map("n", "-", [[<cmd>vertical resize -5<cr>]], { desc = "Make window narrower (horizontally)" }) -- make the window smaller vertically
map("n", "+", [[<cmd>horizontal resize +2<cr>]], { desc = "Make window taller (vertically)" }) -- make the window bigger horizontally by pressing shift and =
map("n", "_", [[<cmd>horizontal resize -2<cr>]], { desc = "Make window shorter (vertically)" }) -- make the window smaller horizontally by pressing shift and -

-- Tabs
map("n", "<leader>tt", ":tabnew<CR>")
map("n", "<leader>tn", ":tabn<CR>")
map("n", "<leader>tp", ":tabp<CR>")

-- Copy+paste from/to system clip board
map("v", "<leader>y", '"+y')
map("n", "<leader>y", '"+y')
map("n", "<leader>Y", '"+yg_')
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
map("v", "<leader>p", '"+p')
map("v", "<leader>P", '"+P')

-- Paste without yanking in visual mode
map("x", "p", "P")

-- Close all buffers
map("n", "<leader>bda", ":%bd<CR>", { desc = "Close all buffers" })

-- todo-comment plugin
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
