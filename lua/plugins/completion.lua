-- Tab Completion Configuration
-- LazyVim default: Tab doesn't accept completion
-- This config: Tab accepts completion, Arrow keys navigate

return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      -- Helper to check if cursor is after text
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      opts.mapping = opts.mapping or {}

      local function supertab(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end

      -- Tab: Accept completion or jump to next snippet placeholder
      local tab_mapping = cmp.mapping(supertab, { "i", "s" })
      opts.mapping["<Tab>"] = tab_mapping
      opts.mapping["<tab>"] = tab_mapping

      -- Shift-Tab: Previous snippet placeholder
      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
        else
          fallback()
        end
      end, { "i", "s" })

      -- Arrow keys: Navigate completion menu
      opts.mapping["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
      opts.mapping["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })

      -- Enter: Only confirm if explicitly selected
      opts.mapping["<CR>"] = cmp.mapping.confirm({ select = false })

      return opts
    end,
  },
}
