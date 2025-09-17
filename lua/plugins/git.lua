return {
  -- Extra Git keymaps that build on LazyVim's fugitive/rhubarb integration
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    keys = function()
      return {
        -- Open permalink in browser (usually provided by LazyVim already)
        { "<leader>gB", ":GBrowse<CR>", mode = { "n", "v" }, desc = "Open permalink in browser" },
        -- Copy permalink (respecting range/selection) to clipboard instead of opening
        { "<leader>gy", ":GBrowse!<CR>", mode = { "n", "v" }, desc = "Yank permalink to clipboard" },
      }
    end,
  },
}

