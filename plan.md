# Neovim Config Modernization Plan

## Context

Current state: LazyVim v8 config targeting Neovim (version from nixpkgs).
Goal: Update to Neovim 0.11.x, latest LazyVim, clean up unused/redundant
config, wire up neotest properly, and refine for a tmux + workmux + Claude Code
terminal workflow.

---

## Phase 1: Foundation — Neovim & LazyVim Version Bump

### 1.1 Verify Neovim version via nix-config
- [ ] Check which Neovim version your nixpkgs pin provides (must be >= 0.11.2
  for current LazyVim). If outdated, update `flake.lock` in nix-config or add a
  neovim overlay to get 0.11.x.
- **Action required in nix-config repo** — this plan will document what's needed
  but the actual nix change happens there.

### 1.2 Update all plugins
- [ ] Run `:Lazy sync` to pull latest commits for all plugins.
- [ ] Update `lazy-lock.json` with new SHAs.
- [ ] Run `:checkhealth` and fix any new warnings.

### 1.3 Bump LazyVim install_version
- [ ] After sync, update `lazyvim.json` version field if LazyVim prompts.
- [ ] Review LazyVim NEWS.md for any breaking changes since v8.

---

## Phase 2: Cleanup — Remove Redundancy & Dead Config

### 2.1 Remove `mini.lua` (empty/no-op)
- The file is just comments — it does nothing. Delete
  `lua/plugins/mini.lua`.

### 2.2 Remove `telescope.nvim` from lock file
- You've switched to Snacks picker (`vim.g.lazyvim_picker = "snacks"`), but
  Telescope is still in `lazy-lock.json`. Confirm it's not loaded, then let
  `:Lazy clean` remove it.

### 2.3 Remove `bufferline.nvim` and `tokyonight.nvim` if unused
- Both are in `lazy-lock.json` (LazyVim defaults) but you use Catppuccin and
  may not use bufferline tabs. If you don't use the tab bar, disable
  bufferline explicitly: `{ "akinsho/bufferline.nvim", enabled = false }`.
- Similarly disable tokyonight if Catppuccin is your only theme.

### 2.4 Audit `lazyvim.json` extras vs `lazy.lua` imports
- Currently extras are declared in **both** `lazyvim.json` and `lua/config/lazy.lua`.
  The `lazyvim.json` list is missing `lang.go`, `dap.core`, `test.core`, and
  `coding.mini-surround` which ARE in `lazy.lua`. Sync these — `lazyvim.json`
  should be the source of truth (LazyVim reads it automatically).
  Alternatively, keep all imports in `lazy.lua` explicitly and treat
  `lazyvim.json` as LazyVim's internal tracking file. Pick one approach.

### 2.5 Clean up `AGENTS.md` stale references
- References to `PLUGINS.md` (doesn't exist), `:Telescope keymaps` (you use
  Snacks now), and Legendary (`:Config`, `:Plugins`) which isn't installed.
  Update to match actual tooling.

---

## Phase 3: Neotest — Wire Up Test Runner

### 3.1 Current state
- `lazyvim.plugins.extras.test.core` is imported (provides neotest).
- `lazyvim.plugins.extras.lang.go` provides `neotest-golang`.
- But there are **no keymaps** for running tests in your config.

### 3.2 Add test runner keymaps
- [ ] Add a `lua/plugins/testing.lua` with keymaps under `<leader>t`:

```lua
return {
  {
    "nvim-neotest/neotest",
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run last test" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest test" },
    },
  },
}
```

### 3.3 Add TypeScript/JS test adapter
- Currently only Go has a test adapter. Add `neotest-vitest` or
  `neotest-jest` depending on your JS test runner.
- [ ] Add adapter to `testing.lua` config.

### 3.4 Register `<leader>t` in which-key
- [ ] Add `{ "<leader>t", group = "test" }` to `lua/plugins/which-key.lua`.

---

## Phase 4: Tmux Integration

### 4.1 Add `vim-tmux-navigator`
- Your config has **no tmux navigation integration**. This is a significant
  workflow gap when using tmux + workmux.
- [ ] Add to a new `lua/plugins/tmux.lua`:

```lua
return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (tmux-aware)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (tmux-aware)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (tmux-aware)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (tmux-aware)" },
    },
  },
}
```

- **Nix-config dependency**: tmux must also have the matching
  `vim-tmux-navigator` tmux plugin configured in `workstream.nix`
  (`programs.tmux.plugins`). Document this requirement.

---

## Phase 5: Workflow Refinements

### 5.1 Review CodeCompanion config for Claude Code coexistence
- With Claude Code running in a tmux pane alongside Neovim, the in-editor AI
  (CodeCompanion) may be redundant for some tasks. Options:
  - **Keep both** — CodeCompanion for inline edits, Claude Code for broader tasks.
  - **Simplify** — If you primarily use Claude Code, consider reducing
    CodeCompanion keymaps or lazy-loading it more aggressively.
- [ ] Decide and adjust `lua/plugins/codecompanion.lua` accordingly.

### 5.2 Consolidate git workflow
- You have **three** git plugin layers: LazyGit (snacks), Diffview, and
  GHLite. With Claude Code handling PR review and git operations:
  - **Keep LazyGit** — fast interactive staging/commits.
  - **Keep Diffview** — visual diff review is valuable.
  - **Evaluate GHLite** — if Claude Code + `gh` CLI covers your PR review
    workflow, consider removing GHLite to reduce complexity.
- [ ] Decide and adjust `lua/plugins/git-pr-review.lua`.

### 5.3 Snacks picker LSP keymaps — check for conflicts
- Your `<leader>l*` bindings remap over LazyVim defaults. Verify these all
  still work after the plugin update (Snacks picker API may have changed).

---

## Phase 6: Performance Review

### 6.1 Measure startup time
- [ ] Run `nvim --startuptime /tmp/startup.log +q && sort -k2 /tmp/startup.log | tail -20`
- [ ] Review which plugins load at startup vs lazily.

### 6.2 Lazy-load more aggressively
- `smear-cursor.nvim` loads at startup (`lazy = false`) — could load on
  `VeryLazy` event instead.
- `which-key.nvim` similarly — confirm it lazy-loads on key press.

### 6.3 Disabled rtp plugins — expand list
- Currently disabling gzip, tar, tohtml, zip. Consider also disabling
  `netrwPlugin` (you use Oil) and `tutor`.

---

## Phase 7: Final Validation & Push

### 7.1 Format and lint
- [ ] Run `stylua lua/` to format all Lua files.
- [ ] Run `nvim --headless "+Lazy! sync" +qa` to verify plugin specs compile.
- [ ] Run `nvim --headless "+checkhealth" +qa` to check for issues.

### 7.2 Smoke test
- [ ] Open a TypeScript file — verify LSP, completion, formatting.
- [ ] Open a Go file — verify LSP, completion, test runner.
- [ ] Test `<leader>t*` keymaps with a real test file.
- [ ] Test `<C-h/j/k/l>` tmux navigation (requires tmux).
- [ ] Verify all `<leader>l*`, `<leader>g*`, `<leader>y*` keymaps work.

### 7.3 Commit and push
- [ ] Commit with: `feat: modernize neovim config — update plugins, add neotest keymaps, tmux nav, cleanup`
- [ ] Push to branch.

---

## Nix-Config Coordination (Out of Scope — Document Only)

These changes should be made in `jackhutson/nix-config` separately:

1. **Neovim version**: Ensure nixpkgs pin provides Neovim >= 0.11.2 (ideally
   0.11.7). Run `nix eval nixpkgs#neovim-unwrapped.version` to check.
2. **Tmux plugin**: Add `vim-tmux-navigator` to `programs.tmux.plugins` in
   `workstream.nix`.
3. **Mason dependencies**: Ensure system packages for Mason-installed tools
   are available (node, go, unzip, etc.) in the nix environment.

---

## Summary of File Changes

| Action | File |
|--------|------|
| Delete | `lua/plugins/mini.lua` |
| Create | `lua/plugins/testing.lua` |
| Create | `lua/plugins/tmux.lua` |
| Edit   | `lua/plugins/which-key.lua` (add test group) |
| Edit   | `lua/config/lazy.lua` (sync extras, expand disabled_plugins) |
| Edit   | `lazyvim.json` (sync extras list) |
| Edit   | `AGENTS.md` (fix stale references) |
| Edit   | `lua/plugins/essentials.lua` (optional: disable bufferline) |
| Update | `lazy-lock.json` (via :Lazy sync) |
| Review | `lua/plugins/codecompanion.lua` (decide on scope) |
| Review | `lua/plugins/git-pr-review.lua` (decide on GHLite) |
