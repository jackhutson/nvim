return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({

        flavour = "mocha", -- Options: "latte", "frappe", "macchiato", "mocha"
        transparent_background = true,
        float = {
          transparent = true,
          solid = false,
        },
        auto_integrations = true,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
