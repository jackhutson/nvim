-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable spell checking in markdown files
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- NOTE: a FileType autocmd that calls vim.diagnostic.config() used to live here
-- to hide virtual_text in markdown. It was removed because that call mutates the
-- GLOBAL diagnostic config (no namespace/buffer scope), so opening one markdown
-- buffer disabled virtual_text everywhere with no restore. Markdown linters are
-- already disabled in lua/plugins/formatting.lua, so diagnostics stay quiet.
-- Toggle virtual_text per-session with <leader>ud if needed.
