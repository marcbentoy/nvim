return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			css = { "prettier" },
			eruby = { "htmlbeautifier" },
			markdown = { "typos", "mdformat" },
			html = { "htmlbeautifier" },
			javascript = { "prettier" },
			json = { "fixjson" },
			lua = { "stylua" },
			proto = { "buf" },
			sh = { "beautysh" },
			sql = { "pg_format" },
			templ = { "htmlbeautifier", "templ" },
			typescript = { "prettier" },
			vue = { "prettier" },
			yaml = { "yamlfix", "yamlfmt" },
		},
	},
}
