# Neovim Config Modernization Plan

## Context

Current state: LazyVim v8 config targeting Neovim (version from nixpkgs).
Goal: Update to Neovim 0.11.x (latest stable: 0.11.7), latest LazyVim, clean up
unused/redundant config, wire up neotest properly, and refine for a tmux +
workmux + Claude Code terminal workflow.

---

## Decisions Made

- **CodeCompanion**: Removed — Claude Code in tmux pane replaces in-editor AI
- **GHLite**: Keeping — useful for in-editor PR review
- **Bufferline**: Disabled — not used
- **Tokyonight**: Disabled — Catppuccin is the only theme
- **Test runner**: Vitest (primary), Jest (legacy) via neotest-vitest adapter
- **Neovim 0.12**: Not yet stable, targeting 0.11.x

---

## Completed Changes

### Phase 2: Cleanup
- [x] Deleted `lua/plugins/mini.lua` (empty no-op file)
- [x] Deleted `lua/plugins/codecompanion.lua`
- [x] Disabled `bufferline.nvim` and `tokyonight.nvim` in essentials.lua
- [x] Synced `lazyvim.json` extras to match `lazy.lua` imports (added go, dap.core, test.core, mini-surround)
- [x] Updated `AGENTS.md` — removed references to PLUGINS.md, Telescope, Legendary; updated to Snacks picker
- [x] Disabled `netrwPlugin` and `tutor` in rtp disabled_plugins

### Phase 3: Neotest
- [x] Created `lua/plugins/testing.lua` with `<leader>t*` keymaps
- [x] Added `neotest-vitest` adapter for TypeScript/JS
- [x] Registered `<leader>t` group in which-key

### Phase 4: Tmux Integration
- [x] Created `lua/plugins/tmux.lua` with `vim-tmux-navigator` (`<C-h/j/k/l>`)

### Phase 7: Format
- [x] Ran `stylua lua/` to format all files

---

## Remaining Steps (User Action Required)

### Plugin Sync
- [ ] Run `:Lazy sync` interactively to pull latest plugin versions
- [ ] Run `:Lazy clean` to remove orphaned plugins (telescope, codecompanion deps)
- [ ] Commit updated `lazy-lock.json`

### Neovim Version (nix-config repo)
- [ ] Check: `nix eval nixpkgs#neovim-unwrapped.version` — must be >= 0.11.2
- [ ] If outdated, update `flake.lock` or add neovim overlay

### Tmux Plugin (nix-config repo)
- [ ] Add `vim-tmux-navigator` tmux plugin to `programs.tmux.plugins` in `workstream.nix`

### Smoke Test
- [ ] Open a TypeScript file — verify LSP, completion, formatting
- [ ] Open a Go file — verify LSP, completion, test runner
- [ ] Test `<leader>t*` keymaps with a real test file
- [ ] Test `<C-h/j/k/l>` tmux navigation
- [ ] Verify `<leader>l*`, `<leader>g*`, `<leader>y*` keymaps still work
- [ ] Run `:checkhealth` and resolve any warnings

### Performance (Optional)
- [ ] `nvim --startuptime /tmp/startup.log +q && sort -k2 /tmp/startup.log | tail -20`
- [ ] Consider lazy-loading `smear-cursor.nvim` on `VeryLazy` event
