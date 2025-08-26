# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

### Neovim Plugin Management
```bash
# Update plugins - Open Neovim and run:
:Lazy sync

# View plugin status:
:Lazy
```

### Development Workflow
- This is a Neovim configuration repository, not a traditional codebase with build/test commands
- Changes to any Lua files take effect after restarting Neovim or sourcing the file with `:so %`
- To test changes immediately, use `:lua require("module.name")` to reload specific modules

## Architecture Overview

### Entry Point Flow
1. `init.lua` - Sets up clipboard, leader key, and loads the hans module
2. `lua/hans/init.lua` - Core module that orchestrates loading of:
   - Options (`opts.lua`)
   - Keymaps (`keymaps.lua`)
   - Plugin manager (`lazy.lua`)
   - Autocommands (`autocmds.lua`)

### Plugin System
- Uses **lazy.nvim** as the plugin manager
- Plugins are organized by category in `lua/plugins/`:
  - `lsp.lua` - Language server configuration with Mason
  - `telescope.lua` - Fuzzy finder setup
  - `treesitter.lua` - Syntax highlighting
  - `git.lua` - Git integration
  - `ai.lua` - AI assistant plugins
  - `debugging.lua` - Debug adapter protocol
  - `editing.lua` - Text editing enhancements
  - `theme.lua` - Color schemes
  - `ui.lua` - UI improvements

### Key Customizations

#### LSP Configuration
- Auto-installs language servers via Mason
- Supports: Go, Rust, TypeScript/JavaScript, Lua, Python
- TypeScript/Deno conflict handling built-in
- Custom formatting toggle with `:KickstartFormatToggle`
- Async Python formatting in virtual environments

#### Custom Diagnostics
- `lua/hans/diagnostics.lua` implements a custom floating diagnostic viewer
- Shows diagnostics with custom icons and source information
- Triggered with `<leader>df` keybinding

#### Keybindings
- Leader key: Space
- Window navigation: `Ctrl+h/j/k/l`
- LSP actions: `gd` (definition), `K` (hover), `<leader>rn` (rename)
- Custom diagnostic float: `<leader>df`

### Important Notes
- WSL clipboard support is auto-detected
- The configuration includes the author's own `present.nvim` plugin for presentations
- Uses `blink.cmp` for completion instead of nvim-cmp
- Auto-save is enabled (`autowriteall`)