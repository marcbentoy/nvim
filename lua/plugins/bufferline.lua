return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        local buff = require("bufferline")
        buff.setup{}

        buff.diagnostics = "nvim_lsp" 
    end
}
