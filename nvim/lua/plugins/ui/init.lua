return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "LazyFile",
    opts = {
      render = "foreground",
      virtual_symbol = require("app.icons").ui.Round,
      enable_named_colors = false,
      enable_tailwind = true,
      custom_colors = {},
    },
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require("vscode").setup({
        color_overrides = {
          vscBack = "#000000",
        },
      })
      vim.opt.background = "dark"
      vim.cmd.colorscheme("vscode")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = require("plugins.ui.statusline").setup,
  },
  { "nvim-tree/nvim-web-devicons", event = "LazyFile" },
  {
    "muniftanjim/nui.nvim",
    event = "LazyFile",
    config = function()
      require("plugins.ui.input").setup()
      require("plugins.ui.quickfix").setup()
    end,
  },
}
