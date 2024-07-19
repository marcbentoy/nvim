-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- url: https://github.com/hrsh7th/nvim-cmp

local icons = {
    Class = "󰠱",
    Constructor = "",
    Constant = "",
    Copilot = "",
    Enum = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "󰡱",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "󰕳",
    Property = "",
    Snippet = "",
    Struct = "",
    Text = "󰊄",
    Variable = "󱄑",
}

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "rasulomaroff/cmp-bufname",
        "SergioRibera/cmp-dotenv",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        -- local lspkind = require("lspkind")

        -- local has_words_before = function()
        -- 	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        -- 		return false
        -- 	end
        -- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        -- 	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
        -- end

        local borderstyle = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        }

        cmp.setup({
            -- Load sources, see: https://github.com/topics/nvim-cmp
            sources = {
                { name = "copilot" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
                { name = "bufname" },
                { name = "dotenv" },
                {
                    name = "html-css",
                    option = {
                        enable_on = { "html", "vue", "ejs", "pug", "eruby", "haml" },
                        file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
                        style_sheets = {
                            -- example of remote styles, only css no js for now
                            "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
                        },
                    },
                },
                { name = "nvim_lsp_signature_help" },
            },
            -- Window styles
            window = {
                completion = borderstyle,
                documentation = borderstyle,
            },
            -- Load snippet support
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                -- format = lspkind.cmp_format(),
                format = function(entry, vim_item)
                    local kind = vim_item.kind
                    vim_item.kind = (icons[kind] or "") .. " " .. vim_item.kind

                    local source = entry.source.name
                    vim_item.menu = "[" .. source .. "]"
                    return vim_item
                end,
            },
            -- Completion settings
            completion = {
                --completeopt = 'menu,menuone,noselect'
                keyword_length = 1,
            },
            experimental = {
                ghost_text = true,
            },
            -- Key mapping
            mapping = {
                ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-l>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping(function(fallback)
                    local do_select = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    })

                    if cmp.get_selected_entry() then
                        do_select()
                    else
                        fallback()
                    end
                end),

                -- Tab mapping
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end),
            },
        })
    end,
}
