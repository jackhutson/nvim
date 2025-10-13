return {
  -- LazyGit: Fast terminal UI for git (via snacks.nvim)
  {
    "folke/snacks.nvim",
    opts = {
      lazygit = {
        configure = true, -- Auto-configure colorscheme integration
      },
      gitbrowse = {}, -- Open files/repos in browser
    },
    keys = {
      { "<leader>gn", function() Snacks.lazygit() end, desc = "LazyGit" },
      { "<leader>gN", function() Snacks.lazygit.log() end, desc = "LazyGit Log" },
      { "<leader>glf", function() Snacks.lazygit.log_file() end, desc = "LazyGit File History" },
      { "<leader>gy", function() Snacks.gitbrowse() end, mode = { "n", "v" }, desc = "Copy Git Link" },
      { "<leader>gY", function() Snacks.gitbrowse({ open = true }) end, mode = { "n", "v" }, desc = "Open Git Link" },
    },
  },
}

