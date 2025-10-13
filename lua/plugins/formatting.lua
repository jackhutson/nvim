return {
  -- Conform: format-on-save and formatter preferences
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts = opts or {}
      local util = require("conform.util")

      local function read_package_json(root)
        local package_path = vim.fs.joinpath(root, "package.json")
        if vim.fn.filereadable(package_path) == 0 then
          return nil
        end
        local ok, lines = pcall(vim.fn.readfile, package_path)
        if not ok then
          return nil
        end
        return table.concat(lines, "\n")
      end

      local function find_eslint_config_root(ctx)
        if not ctx or not ctx.dirname then
          return nil
        end
        local matches = vim.fs.find(function(name)
          return name == ".eslintrc"
            or name == "eslint.config"
            or name:match("^%.eslintrc%.")
            or name:match("^eslint%.config%.")
        end, {
          upward = true,
          path = ctx.dirname,
          limit = 1,
        })
        local match = matches[1]
        if match then
          return vim.fs.dirname(match)
        end
        return nil
      end

      local function find_package_root(ctx)
        if not ctx or not ctx.dirname then
          return nil
        end
        local results = vim.fs.find("package.json", {
          upward = true,
          path = ctx.dirname,
          limit = 1,
        })
        local package_json_path = results[1]
        if package_json_path then
          return vim.fs.dirname(package_json_path)
        end
        return nil
      end

      local function find_eslint_root(ctx)
        local root = find_eslint_config_root(ctx)
        if root then
          return root
        end
        local pkg_root = find_package_root(ctx)
        if not pkg_root then
          return nil
        end
        local package_json = read_package_json(pkg_root)
        if package_json and package_json:find('"eslintConfig"') then
          return pkg_root
        end
        return nil
      end

      local function has_local_binary(root, binary)
        if not root then
          return false
        end
        local results = vim.fs.find("node_modules/.bin/" .. binary, {
          upward = true,
          path = root,
          limit = 1,
        })
        local bin = results[1]
        return bin ~= nil and vim.fn.executable(bin) == 1
      end

      local function eslint_condition(_, ctx)
        local root = find_eslint_root(ctx)
        if not root then
          return false
        end
        return has_local_binary(root, "eslint")
      end

      local function eslint_cwd(_, ctx)
        return find_eslint_root(ctx)
      end

      local function eslint_formatters()
        return { "eslint", "prettier", stop_after_first = true }
      end

      -- Prefer project-local eslint for JS/TS, fall back to Prettier. Use Prettier for Markdown/MDX.
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = eslint_formatters(),
        javascriptreact = eslint_formatters(),
        typescript = eslint_formatters(),
        typescriptreact = eslint_formatters(),
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
        eslint = {
          inherit = false,
          command = util.from_node_modules("eslint"),
          args = { "--fix", "--stdin", "--stdin-filename", "$FILENAME" },
          cwd = eslint_cwd,
          condition = eslint_condition,
          exit_codes = { 0, 1 },
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
