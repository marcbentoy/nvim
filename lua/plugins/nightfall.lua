return {
  "2giosangmitom/nightfall.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
    config = function()
        require("nightfall").setup()

        vim.cmd([[colorscheme deepernight]])
    end
}
