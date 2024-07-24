return {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    },
    lazy = false,
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			ignore = "^$",
			toggler = {
				---Line-comment toggle keymap
				line = "<leader>cc",
				---Block-comment toggle keymap
				block = "<leader>gc",
			},
			---LHS of operator-pending mappings in NORMAL and VISUAL mode
			opleader = {
				---Line-comment toggle keymap
				line = "<leader>cc",
				---Block-comment toggle keymap
				block = "<leader>gc",
			},
		})

        local ft = require('Comment.ft')
        ft.set('pug', '//%s')
        ft.set('templ', '<!-- %s -->')
	end,
}
