return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        blink_cmp = true,
        bufferline = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        markdown = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "lavender",
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        semantic_tokens = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    init = function()
      -- Fix for LazyVim's bufferline integration expecting .get() instead of .get_theme()
      local function patch_bufferline()
        local ok, bufferline_integration = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and bufferline_integration and not bufferline_integration.get and bufferline_integration.get_theme then
          bufferline_integration.get = bufferline_integration.get_theme
        end
      end
      -- Apply patch immediately and on colorscheme changes
      patch_bufferline()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "catppuccin*",
        callback = patch_bufferline,
      })
    end,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}