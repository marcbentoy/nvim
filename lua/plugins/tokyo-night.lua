return {
  "folke/tokyonight.nvim",
  config = function()
      require("tokyonight").setup()

      vim.cmd([[colorscheme tokyonight-moon]])
  end,
--  lazy = false,
--  priority = 1000,
--  opts = {},
}
