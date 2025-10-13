return {
  -- Conform: format-on-save and formatter preferences
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts = opts or {}
      local util = require("conform.util")

      -- Prefer eslint_d for JS/TS; fallback to Prettier. Use Prettier for Markdown/MDX.
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = { { "eslint_d", "eslint" }, "prettier" },
        javascriptreact = { { "eslint_d", "eslint" }, "prettier" },
        typescript = { { "eslint_d", "eslint" }, "prettier" },
        typescriptreact = { { "eslint_d", "eslint" }, "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        mdx = { "prettier" },
      })

      -- Formatter fine-tuning: prefer local project binaries and correct cwd
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
        eslint_d = {
          prefer_local = "node_modules/.bin",
          cwd = util.root_file({
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.json",
            "package.json",
          }),
          condition = util.root_file({
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.json",
            "package.json",
          }),
        },
        eslint = {
          prefer_local = "node_modules/.bin",
          cwd = util.root_file({
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.json",
            "package.json",
          }),
          condition = util.root_file({
            "eslint.config.js",
            "eslint.config.mjs",
            "eslint.config.cjs",
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.cjs",
            ".eslintrc.json",
            "package.json",
          }),
        },
        prettier = {
          prefer_local = "node_modules/.bin",
          cwd = util.root_file({
            "package.json",
            ".prettierrc",
            ".prettierrc.json",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.mjs",
            ".prettierrc.yaml",
            ".prettierrc.yml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
            "prettier.config.ts",
          }),
        },
      })

      return opts
    end,
  },

  -- nvim-lint: reduce noisy markdown diagnostics (we rely on formatting instead)
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts = opts or {}
      opts.linters_by_ft = opts.linters_by_ft or {}
      -- Disable markdown linters unless you explicitly add them back later
      opts.linters_by_ft.markdown = {}
      opts.linters_by_ft.mdx = {}
      return opts
    end,
  },
}
