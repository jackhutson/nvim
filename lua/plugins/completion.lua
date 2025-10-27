-- Completion Configuration with blink.cmp
-- Using super-tab: Tab accepts completion, Enter inserts newline

return {
  {
    "saghen/blink.cmp",
    opts = {
      -- Use super-tab preset: Tab accepts, Shift-Tab for snippets
      keymap = { preset = "super-tab" },

      -- Enable ghost text for inline completion preview
      completion = {
        ghost_text = {
          enabled = true,
        },
      },

      -- Appearance: use nerd fonts
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      -- Sources are automatically configured by LazyVim's Copilot extra
      -- Default order will be: LSP > Copilot > Snippets > Path
    },
  },
}
