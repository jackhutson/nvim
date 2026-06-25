-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Press <leader>sk to search all keymaps

local map = vim.keymap.set

-- Remove default LazyGit duplicates in favor of <leader>gn/gN
pcall(vim.keymap.del, "n", "<leader>gg")
pcall(vim.keymap.del, "n", "<leader>gG")

-- Better indenting (keep selection in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlighting with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear search highlight" })

-- Quick save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Better up/down (deals with word wrap)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Paste without yanking in visual mode
map("x", "<leader>p", [["_dP]], { desc = "Paste without yank" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Copy file path with line number
map("n", "<leader>yp", function()
  local path = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local result = path .. ":" .. line
  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result, vim.log.levels.INFO)
end, { desc = "Copy file path with line number" })

-- Yank diagnostic at cursor line
map("n", "<leader>yd", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
  if #diagnostics == 0 then
    vim.notify("No diagnostic at cursor", vim.log.levels.WARN)
    return
  end
  local messages = {}
  for _, diag in ipairs(diagnostics) do
    table.insert(messages, diag.message)
  end
  local result = table.concat(messages, "\n")
  vim.fn.setreg("+", result)
  vim.notify("Copied diagnostic: " .. messages[1]:sub(1, 50) .. "...", vim.log.levels.INFO)
end, { desc = "Yank diagnostic at line" })

-- Yank all diagnostics in file
map("n", "<leader>yD", function()
  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics == 0 then
    vim.notify("No diagnostics in file", vim.log.levels.WARN)
    return
  end
  local messages = {}
  for _, diag in ipairs(diagnostics) do
    local line = diag.lnum + 1
    table.insert(messages, string.format("Line %d: %s", line, diag.message))
  end
  local result = table.concat(messages, "\n")
  vim.fn.setreg("+", result)
  vim.notify("Copied " .. #diagnostics .. " diagnostics", vim.log.levels.INFO)
end, { desc = "Yank all diagnostics in file" })

-- LSP helpers
map("n", "<leader>lh", function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.lsp.inlay_hint and vim.lsp.inlay_hint.is_enabled then
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    vim.notify((enabled and "Disabled" or "Enabled") .. " inlay hints", vim.log.levels.INFO)
  else
    vim.notify("Inlay hints are not supported by this version of Neovim", vim.log.levels.WARN)
  end
end, { desc = "Toggle Inlay Hints" })

map("n", "<leader>lk", vim.lsp.buf.signature_help, { desc = "Signature Help" })

-- Review this branch's changes (vs origin/HEAD) in hunk, the terminal diff
-- reviewer. Mirrors the `dv` shell function's three-dot range. hunk reads
-- $EDITOR (= nvim), so pressing `e` on a file opens it back in nvim at the line.
map("n", "<leader>gv", function()
  local base = vim.trim(vim.fn.system("git rev-parse --abbrev-ref origin/HEAD 2>/dev/null"))
  if base == "" or vim.v.shell_error ~= 0 then
    base = "main"
  end
  Snacks.terminal("hunk diff " .. base .. "...HEAD")
end, { desc = "Hunk: review branch vs origin/HEAD" })

-- Render the current markdown file with glow in a floating pager. glow reads
-- from disk, so write first to capture unsaved tweaks. The float is interactive
-- (auto-closes when glow exits): scroll with j/k, press `q` to close and land
-- back on the line you left. Loop: tweak -> <leader>mp -> read -> q -> repeat.
map("n", "<leader>mp", function()
  if vim.bo.modifiable and vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd("silent write")
  end
  Snacks.terminal("glow -p " .. vim.fn.shellescape(vim.fn.expand("%:p")), {
    interactive = true, -- start_insert + auto_insert + auto_close
    win = {
      style = "float",
      width = 0.8,
      height = 0.85,
      border = "rounded",
      title = " 󰍔 " .. vim.fn.expand("%:t") .. " ",
      title_pos = "center",
    },
  })
end, { desc = "Markdown preview (glow)" })
