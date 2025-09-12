# Neovim Plugin Documentation

This document explains the purpose and usage of each plugin in your Neovim configuration.

## AI & Code Assistance

### **Codeium** (LazyVim Extra)
- **Purpose**: Free AI-powered code completions similar to GitHub Copilot
- **Usage**: Completions appear automatically as you type in the completion menu
- **Key Bindings**: Accept suggestions with Tab, navigate with arrow keys
- **Note**: Requires authentication on first use with `:Codeium Auth`

### **Claude Code** (`greggh/claude-code.nvim`)
- **Purpose**: Integrates Claude Code CLI directly in Neovim for AI-assisted coding
- **Usage**: Toggle Claude Code terminal with `<leader>cc`
- **Key Bindings**:
  - `<leader>cc` - Toggle Claude Code window
  - `<leader>ct` - Start new Claude Code task
- **Note**: Auto-reloads files when Claude makes changes

### **TS Error Translator** (`dmmulroy/ts-error-translator.nvim`)
- **Purpose**: Translates cryptic TypeScript errors into plain English
- **Usage**: Automatically translates errors in diagnostics window
- **When to Use**: When working with complex TypeScript types and generics

## Navigation & File Management

### **Harpoon** (LazyVim Extra)
- **Purpose**: Quick navigation between frequently used files
- **Usage**: Mark files you're actively working on and jump between them instantly
- **Key Bindings**:
  - `<leader>H` - Add current file to Harpoon
  - `<leader>h` - Open Harpoon menu
  - `<leader>1-5` - Jump to harpooned file 1-5
- **When to Use**: When working on a feature across 3-5 files

### **Oil.nvim** (`stevearc/oil.nvim`)
- **Purpose**: Edit filesystem like a buffer - rename, create, delete files with vim motions
- **Usage**: Navigate directories and edit filenames directly
- **Key Bindings**:
  - `-` - Open parent directory
  - `<leader>e-` - Open Oil explorer
- **When to Use**: For file operations without leaving Neovim

### **Telescope** (Built into LazyVim)
- **Purpose**: Fuzzy finder for files, grep, buffers, and more
- **Key Bindings**:
  - `<leader>ff` - Find files
  - `<leader>fg` - Live grep
  - `<leader>fb` - Find buffers
  - `<leader>fh` - Find help

## Text Editing

### **Mini Surround** (LazyVim Extra)
- **Purpose**: Add, delete, or change surrounding characters (quotes, brackets, tags)
- **Usage**: Manipulate text objects with surrounding pairs
- **Key Bindings**:
  - `gsa` - Add surrounding
  - `gsd` - Delete surrounding
  - `gsr` - Replace surrounding
  - `gsf` - Find surrounding to the right
- **Examples**: Change "text" to 'text', wrap word in parentheses

### **Vim Illuminate** (LazyVim Extra)
- **Purpose**: Automatically highlights other occurrences of word under cursor
- **Usage**: Helps track variable usage across file
- **When to Use**: Code review, refactoring, understanding code flow

## Search & Replace

### **Spectre** (`nvim-pack/nvim-spectre`)
- **Purpose**: Project-wide find and replace with preview
- **Usage**: Search and replace across entire project with live preview
- **Key Bindings**:
  - `<leader>sr` - Open Spectre
  - `<leader>sw` - Search current word
  - `<leader>sp` - Search in current file
- **When to Use**: Renaming variables/functions across multiple files

## Command & Discovery

### **Legendary** (`mrjones2014/legendary.nvim`)
- **Purpose**: VS Code-style command palette - search all commands, keymaps, and autocmds
- **Usage**: Discover forgotten commands and keybindings
- **Key Bindings**:
  - `<leader>sl` - Search all Legendary items
  - `<leader>sk` - Search keymaps only
  - `<leader>sc` - Search commands only
  - `<leader>sa` - Search autocmds
- **Custom Commands**:
  - `:Config` - Edit Neovim config
  - `:Plugins` - Browse plugins directory
  - `:PluginDocs` - Open this documentation

### **Which-Key** (Built into LazyVim)
- **Purpose**: Shows available keybindings as you type
- **Usage**: Press any leader key and wait to see available options
- **When to Use**: Learning new keybindings or when you forget a command

## Version Control & History

### **Undotree** (`mbbill/undotree`)
- **Purpose**: Visualize and navigate undo history as a tree
- **Usage**: See branching undo history and restore any previous state
- **Key Bindings**:
  - `<leader>u` - Toggle undotree
- **When to Use**: When you need to recover code from multiple undo branches

### **Gitsigns** (Built into LazyVim)
- **Purpose**: Git decorations and inline blame
- **Usage**: See git changes in the gutter, stage hunks, preview diffs
- **Key Bindings**:
  - `]h` / `[h` - Next/previous hunk
  - `<leader>hs` - Stage hunk
  - `<leader>hr` - Reset hunk
  - `<leader>hp` - Preview hunk

## Note Taking

### **Obsidian** (`epwalsh/obsidian.nvim`)
- **Purpose**: Integration with Obsidian knowledge base
- **Usage**: Create and manage notes with wiki-style links
- **Key Bindings**:
  - `<leader>on` - New note
  - `<leader>os` - Search notes
  - `<leader>oq` - Quick switch
  - `<leader>od` - Today's daily note
  - `<leader>ob` - Show backlinks
- **Note**: Configure vault path in the plugin settings

## UI Enhancements

### **Indent Blankline** (LazyVim Extra)
- **Purpose**: Visual indent guides showing scope
- **Usage**: See indentation levels with vertical lines
- **Key Bindings**:
  - `<leader>ug` - Toggle indent guides
- **When to Use**: Working with deeply nested code

### **Catppuccin** (Already configured)
- **Purpose**: Modern, comfortable color scheme
- **Features**: Transparent background, integrated with all plugins

## LSP & Diagnostics

### **LazyVim LSP** (Built-in)
- **Purpose**: Language server protocol support for all languages
- **Key Bindings**:
  - `gd` - Go to definition
  - `gr` - Go to references
  - `K` - Hover documentation
  - `<leader>ca` - Code actions
  - `<leader>rn` - Rename

## Tips

1. **Use Legendary** (`<leader>sl`) when you forget a command
2. **Use Harpoon** for files you're actively editing
3. **Use Oil** (`-`) for quick file operations
4. **Use Spectre** for project-wide refactoring
5. **Enable Codeium** with `:Codeium Auth` for AI completions
6. **Toggle Claude Code** with `<leader>cc` for AI assistance

## Quick Reference

| Category | Plugin | Primary Keybinding | Purpose |
|----------|--------|-------------------|----------|
| AI | Claude Code | `<leader>cc` | AI coding assistant |
| AI | Codeium | Auto | Inline completions |
| Navigation | Harpoon | `<leader>1-5` | Quick file switching |
| Files | Oil | `-` | File management |
| Search | Spectre | `<leader>sr` | Find & replace |
| Commands | Legendary | `<leader>sl` | Command palette |
| History | Undotree | `<leader>u` | Undo visualization |
| Text | Mini Surround | `gsa/gsd/gsr` | Surround manipulation |
| Notes | Obsidian | `<leader>o...` | Note taking |