return {
  -- Neogit: Interactive Git staging UI (like VS Code's Source Control panel)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
      { "<leader>gN", "<cmd>Neogit commit<cr>", desc = "Neogit Commit" },
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },

  -- GitLinker: Copy GitHub permalinks to files and lines
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Copy Git Link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open Git Link" },
    },
    opts = {
      message = true,
      console_log = false,
      highlight_duration = 300,
      mappings = nil,
      router = {
        browse = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blob/"
            .. "{_A.REV}/"
            .. "{_A.FILE}?plain=1"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
        blame = {
          ["^github%.com"] = "https://github.com/"
            .. "{_A.ORG}/"
            .. "{_A.REPO}/blame/"
            .. "{_A.REV}/"
            .. "{_A.FILE}"
            .. "#L{_A.LSTART}"
            .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
        },
      },
    },
  },
}

