# Nvim Config

Neovim 0.12+ config built on [lazy.nvim](https://github.com/folke/lazy.nvim). Keymaps mirror the
IdeaVim setup in `~/.ideavimrc` where possible, so muscle memory carries over from IntelliJ.

```
init.lua
lua/config/   options, keymaps, autocmds, lazy.nvim bootstrap
lua/plugins/  one file per plugin (or group of related plugins)
```

## Installation

Mac:
```shell
brew install neovim ripgrep fd tree-sitter-cli
```

Archlinux:
```shell
sudo pacman -S neovim ripgrep fd tree-sitter-cli
```

- **ripgrep / fd**: used by the Snacks picker (grep and file search).
- **tree-sitter-cli** (0.26.1+, not from npm) and a C compiler: nvim-treesitter (`main` branch) builds parsers with them.
- **A [Nerd Font](https://www.nerdfonts.com/)** in the terminal for icons.
- **Java**: jdtls runs on the mise JDK at `~/.local/share/mise/installs/java/openjdk-25`. Project runtimes
  (11, 17, 21, 25) are configured in `lua/plugins/java.lua`; update the paths if your JDKs change.
Language servers (lua_ls, ts_ls, pyright, terraformls, kotlin_lsp, gopls) are installed
automatically by Mason, as are the formatters used by conform.nvim (stylua, goimports). jdtls and
spring-boot-tools are installed by nvim-java. Other filetypes are formatted by their language server.

Language servers can't register file watchers (it made quitting hang on macOS), so after big changes
outside Neovim (git checkout, code generation) run `:lsp restart` if a server looks out of date.

Press `<leader>?` to see buffer-local keymaps, or just press `<leader>` and wait: which-key lists everything.

# Shortcuts

`<leader>` is `Space`.

## Editing

|  **Command**  |           **Description**            |
| :-----------: | :----------------------------------: |
|     `gcc`     |          Toggle line comment          |
|     `gc`      | Toggle comment on selection / motion (e.g. `gcip`) |
|      `Y`      |           Yank to end of line         |
|  `<leader>.`  |         Go to last change             |
|  `<leader>d`  |       Delete without yank (motion)    |
|  `<leader>x`  |       Delete char without yank        |
|  `<leader>p`  |   Paste without yank (visual mode)    |
|  `<leader>;`  |        Add `;` to end of line         |
|  `<leader>,`  |        Add `,` to end of line         |

## Windows & buffers

|  **Command**  |      **Description**      |
| :-----------: | :-----------------------: |
|    `<C-h>`    |    Move to left window    |
|    `<C-j>`    |    Move to lower window   |
|    `<C-k>`    |    Move to upper window   |
|    `<C-l>`    |    Move to right window   |
|  `<leader>n`  |        Next buffer        |
|  `<leader>p`  |      Previous buffer      |
|  `<leader>q`  | Close buffer, keep window |
|  `<leader>s`  | Switch buffer (IntelliJ Switcher) |
|     `gt`      |         Next tab          |
|     `gT`      |       Previous tab        |

## Search (Snacks picker)

|  **Command**   |              **Description**              |
| :------------: | :---------------------------------------: |
|    `<C-p>`     |       Go to file (IntelliJ GotoFile)      |
|    `<C-f>`     |  Grep in project (IntelliJ Find in Path)  |
|  `<leader>/`   |           Search in current file          |
|     `z=`       |           Spelling suggestions            |
|  `<leader>km`  |               Search keymaps              |
| `<a-t>` (in picker) | Send results to Trouble (IntelliJ "Open in Find Window") |

## File tree (Snacks explorer)

The tree follows the current file. It refreshes when you save; press `u` after external changes
(git checkout, builds).

|  **Command**   |          **Description**          |
| :------------: | :-------------------------------: |
|    `<C-\>`     |          Toggle file tree         |
| `<CR>` / `l`   |         Open file / folder        |
|      `h`       |           Close folder            |
|     `<BS>`     |          Go up one folder         |
|      `a`       | Add file (end with `/` for folder) |
|      `d`       |              Delete               |
|      `r`       |              Rename               |
|      `c`       |               Copy                |
|      `m`       |               Move                |
|      `y`       |            Yank path(s)           |
|      `p`       |               Paste               |
|      `o`       |    Open with system application   |
|      `P`       |          Toggle preview           |
|      `u`       |              Refresh              |
|      `H`       |       Toggle hidden files         |
|      `I`       |       Toggle ignored files        |
|      `Z`       |        Collapse all folders       |
|      `.`       |       Focus folder as root        |
|   `]g` / `[g`  |        Next / previous git change |
|   `]d` / `[d`  |   Next / previous diagnostic      |
|   `]e` / `[e`  |      Next / previous error        |
|  `<leader>/`   |        Grep in folder             |
|     `<C-c>`    |   Change cwd to folder (`:tcd`)   |

## LSP

Neovim's default LSP keys (`gr` prefix). Press `gr` and wait for which-key to list them.

|   **Command**   |               **Description**                | **Was** |
| :-------------: | :------------------------------------------: | :-----: |
|      `gd`       | Go to definition; on the definition itself, usages popup (IntelliJ Cmd+B) | |
|      `gD`       |              Go to declaration               | |
|      `grr`      |    Find usages (Trouble, IntelliJ Alt+F7)    | `gr` |
|      `gri`      | Go to implementation: jumps if one, popup if several (IntelliJ Cmd+Alt+B) | `gi` |
|      `grt`      |           Go to type definition              | `<leader>D` |
|      `grn`      |                  Rename                      | `<leader>rn` |
|      `gra`      |          Code action (normal / visual)       | `<leader>ca` |
|      `grx`      |                Run codelens                  | |
|      `gO`       |    Document symbols (fuzzy search picker)     | |
|       `K`       |                 Hover docs                   | |
|  `<C-s>` (insert) |            Signature help               | |
|   `<leader>f`   |                Format file                   | |
|   `<leader>e`   |           Show line diagnostic               | |
|  `<leader>wa`   |           Add workspace folder               | |
|  `<leader>wr`   |          Remove workspace folder             | |
|  `<leader>wl`   |          List workspace folders              | |

## Problems & tool windows (Trouble)

|  **Command**   |                     **Description**                      |
| :------------: | :------------------------------------------------------: |
|  `<leader>tp`  |        Problems, whole project (IntelliJ Alt+6)          |
|  `<leader>tf`  |              Problems, current file                      |
|  `<leader>ts`  |         Structure / symbols (IntelliJ Cmd+7)             |
|  `<leader>ch`  |       Call hierarchy (IntelliJ Ctrl+Alt+H)               |
|  `<leader>tq`  |                    Quickfix list                         |
|  `<leader>tl`  |                   Location list                          |
|   `]e` / `[e`  |    Next / previous problem (IntelliJ F2 / Shift+F2)      |
|   `]t` / `[t`  |   Next / previous item in Trouble (or quickfix)          |
|   `]d` / `[d`  |          Next / previous diagnostic (built-in)           |
| `<Esc>` (in Trouble) |                 Close the window                    |

`:copen`, `:lopen`, `:grep`, `:make` and anything else that fills the quickfix / location list open
in Trouble instead of the built-in window.

## Git changes (gitsigns)

Changed lines are marked in the gutter like IntelliJ's change bars.

|  **Command**  |          **Description**           |
| :-----------: | :--------------------------------: |
|  `]h` / `[h`  |     Next / previous change         |
| `<leader>hp`  |   Preview change (inline diff)     |
| `<leader>hr`  | Rollback change (or selected lines) |
| `<leader>hd`  |      Diff file against index       |
| `<leader>hb`  |            Blame line              |

## Debugger & tests

The debug view (nvim-dap-view) opens when a session starts and closes when it ends. Variable
values are shown inline while stopped.

|  **Command**   |       **Description**       |
| :------------: | :-------------------------: |
|  `<leader>tb`  |      Toggle breakpoint      |
|  `<leader>bv`  |  Toggle debug view  |
|  `<leader>bc`  |  Close debug view   |
|     `F5`       |     Start / continue        |
|     `F7`       |         Step into           |
|     `F8`       |         Step over           |
|     `F9`       |          Step out           |
|     `F10`      |          Run last           |
|  `<leader>tm`  |   Run test method (Java)    |
|  `<leader>tc`  |    Run test class (Java)    |
| `<leader>tdm`  |  Debug test method (Java)   |
| `<leader>tdc`  |   Debug test class (Java)   |
|  `<leader>tr`  |  Last test report (Java)    |

## Claude Code (claudecode.nvim)

Runs the `claude` CLI in a terminal split and connects it to Neovim like the IntelliJ plugin: Claude
sees the current selection and diagnostics, and proposed edits open as diffs. The CLI uses its own
config, so Bedrock (`CLAUDE_CODE_USE_BEDROCK`, `AWS_PROFILE`, ...) works as in the terminal. A
`claude` started elsewhere (e.g. a zellij pane) can attach with `/ide` once the plugin is loaded.

|  **Command**  |          **Description**          |
| :-----------: | :-------------------------------: |
| `<leader>ac`  |          Toggle Claude            |
| `<leader>af`  |          Focus Claude             |
| `<leader>ar`  |     Resume a Claude session       |
| `<leader>aC`  |    Continue last conversation     |
| `<leader>am`  |          Select model             |
| `<leader>ab`  |   Add current buffer to context   |
| `<leader>as`  | Send selection (visual) / add file (explorer) |
| `<leader>aa`  |          Accept diff              |
| `<leader>ad`  |           Deny diff               |

## AI (CodeCompanion / Copilot)

Copilot runs as a language server (`copilot-language-server`, installed by Mason) with Neovim's
built-in inline completion. Sign in once with `:LspCopilotSignIn`; an existing Copilot login in
`~/.config/github-copilot` is reused.

|  **Command**  |          **Description**          |
| :-----------: | :-------------------------------: |
| `<leader>cc`  |         Toggle AI chat            |
| `<leader>cp`  |        AI action palette          |
|    `<Tab>`    | Accept Copilot suggestion (insert) |
| `<M-]>` / `<M-[>` | Next / previous Copilot suggestion (insert) |

## Completion (insert mode)

|  **Command**  |      **Description**       |
| :-----------: | :------------------------: |
| `<C-Space>`   |    Open completion menu    |
|    `<CR>`     |     Confirm selection      |
|    `<C-e>`    |      Close menu            |
| `<C-n>`/`<C-p>` |   Next / previous item   |
| `<C-b>`/`<C-f>` |  Scroll docs up / down   |
| `<Tab>`/`<S-Tab>` | Next / previous snippet field (`<Tab>` accepts Copilot first) |
|    `<C-k>`    |  Toggle signature help     |

## Messages (Noice) & help

|  **Command**  |       **Description**       |
| :-----------: | :-------------------------: |
| `<leader>mh`  |      Message history        |
| `<leader>md`  |     Dismiss messages        |
| `<leader>?`   |    Buffer-local keymaps     |
