-- Mini.nvim: Performance-focused alternatives
-- Only swapping where mini.nvim provides clear benefits
-- Keeping LazyVim's choices where they're already excellent

return {
  -- mini.indentscope: Animated scope indicator
  -- Replaces indent-blankline with lighter, animated alternative
  {
    "nvim-mini/mini.indentscope",
    event = "LazyFile",
    opts = function()
      return {
        symbol = "│",
        options = { try_as_border = true },
        draw = {
          delay = 100,
          animation = require("mini.indentscope").gen_animation.none(),
        },
      }
    end,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- Keep LazyVim's existing mini.ai, mini.pairs, mini.bufremove, mini.surround
  -- They're already excellent and don't need configuration
}
