return function()
	local util = require("lspconfig/util")
	local fn = util.root_pattern("go.mod", ".git", "go.work")
	return fn() or vim.fn.getcwd()
end
