-----------------------------------------------------------
-- Neovim LSP configuration file
-----------------------------------------------------------

-- Plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig

-- For configuration see the Wiki: https://github.com/neovim/nvim-lspconfig/wiki
-- Autocompletion settings of "nvim-cmp" are defined in plugins/nvim-cmp.lua

return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig/util")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local ui_windows = require("lspconfig.ui.windows")
		local get_root_dir = require("utils.root-dir")

		ui_windows.default_options.border = "single"

		-- Add additional capabilities supported by nvim-cmp
		-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

		capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.preselectSupport = true
		capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
		capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
		capabilities.textDocument.completion.completionItem.deprecatedSupport = true
		capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
		capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = {
				"documentation",
				"detail",
				"additionalTextEdits",
			},
		}

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(client, bufnr)
			local function buf_set_keymap(...)
				vim.api.nvim_buf_set_keymap(bufnr, ...)
			end

			-- Highlighting references
			if client.server_capabilities.document_highlight then
				vim.api.nvim_exec(
					[[
                      augroup lsp_document_highlight
                        autocmd! * <buffer>
                        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                      augroup END
                    ]],
					false
				)
			end

			-- Disable formatting for some server
			if client.name == "tsserver" then
				client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
			end

			-- See `:help vim.lsp.*` for documentation on any of the below functions
			buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {
				noremap = true,
				silent = true,
				desc = "Go to declaration",
			})

			buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {
				noremap = true,
				silent = true,
				desc = "Go to definition",
			})

			buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show hover",
			})
			buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", {
				noremap = true,
				silent = true,
				desc = "Go to implementation",
			})

			buf_set_keymap("n", "<S-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show signature help",
			})

			-- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
			-- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
			-- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
            
			buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", {
				noremap = true,
				silent = true,
				desc = "Go to type definition",
			})
			buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {
				noremap = true,
				silent = true,
				desc = "Rename",
			})
			buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show code actions",
			})
			buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show references",
			})
			buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.open_float()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show diagnostics",
			})

			-- buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
			-- buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
            --
			buf_set_keymap("n", "<space>fl", "<cmd>lua vim.diagnostic.setqflist()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show diagnostics in quickfix list",
			})
			buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show diagnostics in location list",
			})

			-- Trigger refactoring plugin then auto format
			-- buf_set_keymap("v", "<leader><space>a", ":'<,'>lua vim.lsp.buf.code_action()<CR>", opts)
			buf_set_keymap(
				"v",
				"<leader>ev",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
				{ noremap = true, silent = true, expr = false, desc = "Extract to variable" }
			)
			buf_set_keymap(
				"v",
				"<leader>iv",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
				{ noremap = true, silent = true, expr = false, desc = "Inlide variable" }
			)
			buf_set_keymap(
				"v",
				"<leader>ef",
				[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
				{ noremap = true, silent = true, expr = false, desc = "Extract to function" }
			)
			-- Show all diagnostics on current line in floating window
			buf_set_keymap("n", "<Leader>da", ":lua vim.diagnostic.open_float()<CR>", {
				noremap = true,
				silent = true,
				desc = "Show diagnostics",
			})

			buf_set_keymap(
				"n",
				"<Leader>dn",
				":lua vim.diagnostic.goto_next()<CR>",
				{ noremap = true, silent = true, desc = "Go to next diagnostic line" }
			)

			buf_set_keymap(
				"n",
				"<Leader>dp",
				":lua vim.diagnostic.goto_prev()<CR>",
				{ noremap = true, silent = true, desc = "Go to previous diagnostic line" }
			)

			-- buf_set_keymap("n", "<F3>", ":Format<CR>", {
			-- 	noremap = true,
			-- 	silent = true,
			-- 	desc = "Format code",
			-- })

			-- vim.cmd([[ command! Format execute 'lua require("conform").format { async = true, lsp_fallback = true }' ]])
		end

		--[[

Language servers setup:

For language servers list see:
https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

--]]
		-- Define `root_dir` when needed
		-- See: https://github.com/neovim/nvim-lspconfig/issues/320
		-- This is a workaround, maybe not work with some servers.

		-- Use a loop to conveniently call 'setup' on multiple servers and
		-- map buffer local keybindings when the language server attaches.
		-- Add your language server below:
		local servers = {
			"bashls",
			-- "pbls",
			"pyright",
			-- "rust_analyzer",
			"tsserver",
			"jsonls",
			"cssls",
			"tailwindcss",
			"volar",
			-- "intelephense",
			"ruby_lsp",
			-- "eslint",
			"templ",
			"html",
		}

		-- Call setup
		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({
				on_attach = on_attach,
				root_dir = get_root_dir,
				capabilities = capabilities,
			})
		end

		lspconfig["emmet_language_server"].setup({
			on_attach = on_attach,
			root_dir = get_root_dir,
			filetypes = { "html", "eruby", "templ" },
			capabilities = capabilities,
		})

		-- lspconfig["clangd"].setup({
			-- filetypes = { "clang", "cpp", "c" },
			-- on_attach = on_attach,
			-- root_dir = get_root_dir,
			-- capabilities = capabilities,
		-- })

		lspconfig["lua_ls"].setup({
			on_attach = on_attach,
			root_dir = get_root_dir,
			capabilities = capabilities,
			on_init = function(client)
				local path = client.workspace_folders[1].name
				if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
					return
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths here.
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})

		-- Valid "GO_TAGS" format:
		-- (shell) export GO_TAGS="tag1 tag2"
		local gopls = nil
		local flags = os.getenv("GO_TAGS")
		if flags ~= nil and flags ~= "" then
			gopls = { buildFlags = { "-tags=" .. flags } }
		end

		lspconfig["gopls"].setup({
			cmd = { "gopls", "serve" },
			filetypes = { "go", "gomod", "gowork" },
			on_attach = on_attach,
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			capabilities = capabilities,
			settings = {
				gopls = gopls,
			},
		})

		-- lspconfig["omnisharp"].setup({
			-- on_attach = on_attach,
			-- root_dir = get_root_dir,
			-- capabilities = capabilities,
			-- cmd = { "omnisharp", "--languageserver" },
		-- })
	end,
}
