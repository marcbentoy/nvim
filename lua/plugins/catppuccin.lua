return {
    "catppuccin/nvim",
    priority = 1000 ,
    config = true,
    opts = {},
    config = function()
        require("catppuccin").setup()

        vim.cmd([[colorscheme catppuccin-mocha]])
    end
}
