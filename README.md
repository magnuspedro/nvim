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
  (11, 17, 21, 25) are configured in `lua/plugins/lsp-config.lua`; update the paths if your JDKs change.
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
|     `gcc`     |     Toggle line comment (linewise)    |
|     `gbc`     |     Toggle line comment (blockwise)   |
|     `gc`      |   Toggle comment on selection/motion  |
|     `gb`      | Toggle block comment on selection/motion |
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
|  `<leader>ff`  |                Find files                 |
|    `<C-f>`     |  Grep in project (IntelliJ Find in Path)  |
|  `<leader>gf`  |             Grep in project               |
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

|   **Command**   |               **Description**                |
| :-------------: | :------------------------------------------: |
|      `gd`       | Go to declaration; on the declaration itself, usages popup (IntelliJ Cmd+B) |
|      `gD`       |              Go to declaration               |
|      `gr`       |    Find usages (Trouble, IntelliJ Alt+F7)    |
|      `gi`       | Go to implementation: jumps if one, popup if several (IntelliJ Cmd+Alt+B) |
|       `K`       |                 Hover docs                   |
|  `<C-s>` (insert) |            Signature help               |
|  `<leader>gd`   |         Pick references (Snacks)             |
|  `<leader>gi`   |       Pick implementations (Snacks)          |
|   `<leader>D`   |           Go to type definition              |
|  `<leader>rn`   |                  Rename                      |
|  `<leader>ca`   |                Code action                   |
|   `<leader>f`   |                Format file                   |
|   `<leader>e`   |           Show line diagnostic               |
|  `<leader>wa`   |           Add workspace folder               |
|  `<leader>wr`   |          Remove workspace folder             |
|  `<leader>wl`   |          List workspace folders              |

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

`:copen`, `:lopen`, `:grep`, `:make` and anything else that fills the quickfix / location list open
in Trouble instead of the built-in window.

## Debugger & tests

|  **Command**   |       **Description**       |
| :------------: | :-------------------------: |
|  `<leader>tb`  |      Toggle breakpoint      |
|  `<leader>bc`  |       Close debug UI        |
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

## AI (CodeCompanion / Copilot)

|  **Command**  |          **Description**          |
| :-----------: | :-------------------------------: |
| `<leader>cc`  |         Toggle AI chat            |
| `<leader>cp`  |        AI action palette          |
|    `<Tab>`    | Accept Copilot suggestion (insert) |

## Completion (insert mode)

|  **Command**  |      **Description**       |
| :-----------: | :------------------------: |
| `<C-Space>`   |    Open completion menu    |
|    `<CR>`     |     Confirm selection      |
|    `<C-e>`    |      Close menu            |
| `<C-n>`/`<C-p>` |   Next / previous item   |
| `<C-b>`/`<C-f>` |  Scroll docs up / down   |
| `<Tab>`/`<S-Tab>` | Next / previous snippet field |
|    `<C-k>`    |  Toggle signature help     |

## Messages (Noice) & help

|  **Command**  |       **Description**       |
| :-----------: | :-------------------------: |
| `<leader>mh`  |      Message history        |
| `<leader>md`  |     Dismiss messages        |
| `<leader>?`   |    Buffer-local keymaps     |
