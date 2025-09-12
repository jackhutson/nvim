return {
  "greggh/claude-code.nvim",
  cmd = { "ClaudeCode", "ClaudeCodeToggle" },
  keys = {
    { "<leader>cc", "<cmd>ClaudeCodeToggle<cr>", desc = "Toggle Claude Code" },
    { "<leader>ct", "<cmd>ClaudeCode -c new_task<cr>", desc = "Claude Code New Task" },
  },
  opts = {
    window = {
      position = "float",
      width = 0.8,
      height = 0.8,
      border = "rounded",
    },
    auto_reload = true,
    log_level = "info",
  },
  config = function(_, opts)
    require("claude-code").setup(opts)
    
    -- Auto-reload files when Claude modifies them
    vim.api.nvim_create_autocmd("FocusGained", {
      callback = function()
        vim.cmd("checktime")
      end,
    })
  end,
}