return {
    "ellisonleao/gruvbox.nvim", 
    priority = 1000 ,
    config = true,
    opts = {},
    config = function()
        require("gruvbox").setup()

        vim.cmd([[colorscheme gruvbox]])
    end
}
