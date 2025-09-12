return {
  "mrjones2014/legendary.nvim",
  priority = 10000,
  lazy = false,
  dependencies = {
    "kkharji/sqlite.lua",
  },
  keys = {
    { "<leader>sl", "<cmd>Legendary<cr>", desc = "Search Legendary (commands)" },
    { "<leader>sk", "<cmd>Legendary keymaps<cr>", desc = "Search Keymaps" },
    { "<leader>sc", "<cmd>Legendary commands<cr>", desc = "Search Commands" },
    { "<leader>sa", "<cmd>Legendary autocmds<cr>", desc = "Search Autocmds" },
  },
  opts = {
    scratchpad = {
      view = "float",
      results_view = "float",
    },
    sort = {
      most_recent_first = true,
      user_items_first = true,
    },
    extensions = {
      lazy_nvim = true,
      which_key = {
        auto_register = true,
      },
    },
  },
  config = function(_, opts)
    require("legendary").setup(opts)
    
    -- Add custom commands
    require("legendary").commands({
      {
        ":Config",
        description = "Edit Neovim config",
        command = function()
          vim.cmd("cd ~/.config/nvim")
          vim.cmd("edit init.lua")
        end,
      },
      {
        ":Plugins",
        description = "Open plugins directory",
        command = function()
          vim.cmd("cd ~/.config/nvim/lua/plugins")
          vim.cmd("Telescope find_files")
        end,
      },
      {
        ":PluginDocs",
        description = "Open plugin documentation",
        command = function()
          vim.cmd("edit ~/.config/nvim/PLUGINS.md")
        end,
      },
    })
  end,
}