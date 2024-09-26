return {
	"catppuccin/nvim",
	priority = 1000,
	config = true,
	opts = {},
	config = function()
		local transparent = true

		require("catppuccin").setup({
			transparent_background = transparent,
		})

		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
