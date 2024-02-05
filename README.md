# Nvim Config

## Instalation

### Ripgrep
To use live buffer please install [ripgrep](https://github.com/BurntSushi/ripgrep)

Archlinux:
```shell
sudo pacman -S ripgrep
```

Mac:
```shell
brew install ripgrep
```

### Fuzzy Finder

To make nvim-bqf work we need to install fzf

Archlinux:
```shell
sudo pacman -S fzf
```

Mac:
```shell
brew install fzf
```

### Copilot Chat

Install dependencies for copilot. They are porting to lua, so may be its going to be deprecated

```python 
pip install python-dotenv requests pynvim==0.5.0 prompt-toolkit
pip install tiktoken
```

# Shortcuts


## Main
| **Command** |    **Description**     |
|:-----------:|:----------------------:|
|   `<c-_>`   |    Toggle Comments     |
|   `<c-h>`   |   Move to left pane    |
|   `<c-j>`   |   Move to down pane    |
|   `<c-k>`   |   Move to upper pane   |
|   `<c-l>`   |   Move to right pane   |
| `<leader>.` | Go to previous insert  |
|     `Y`     |   Copy rest of line    |
| `<leader>p`            | Past without copy                       |
| `<leader>d` |  Delete without copy   |
| `<leader>x` |  Delete without copy   |
| `<leader>;` | Add `;` to end of line |
| `<leader>,` | Add `,`to end of line  |
## Lsp
| **Command** |            **Description**             |
|:-----------:|:--------------------------------------:|
| `<leader>e` |            Open diagnostic             |
|    `[d`     |             Go to previous             |
|    `]d`     |               Go to next               |
| `<leader>q` | Add buffer diagnostic to location list |
|    `gD`     |            Go to Declarion             |
|    `gd`     |             Show reference             |
| `gr`            | Go to Definition                                       |
|     `K`     |                Explain                 |
|    `gi`     |          Go to implementation          |
|   `<C-K>`   |       Show signature information       |
| `<space>wa` |          Add workspace folder          |
| `<space>wr` |        Remove workspace folder         |
| `<space>wl` |         List Workspace folders         |
| `<space>D`  |      Go to definition of the type      |
| `<space>rn` |            Refactor rename             |
|  `<A-CR>`   |              Code Action               |
| `<space>f`            | Format file                                       |
## Telescope
| **Command** | **Description** |
| :--: | :--: |
| `<c-p>` | Find File |
| `<c-f>` | Live Grep |
| `<leader>fb` | Show Open Buffers |
| `<leader>fh` | Show Help Tags |
## Tree Lua
|   **Command**   |    **Description**    |
|:---------------:|:---------------------:|
|  `<c-Bslash>`   |    Toggle Tree Lua    |
| `<leader>t`<br> | Show file on Tree Lua |
|     `<C-]>`     |          CD           |
|` <C-E>`|Open: In Place|
|`<C-K>`|Info|
|`<C-R>`|Rename: Omit Filename|
|`<C-T>`|Open: New Tab|
|`<C-V>`|Open: Vertical Split|
|`<C-X>`|Open: Horizontal Split|
|`<BS>`|Close Directory|
|`<CR>`|Open|
|`<Tab>`|Open Preview|
|`.`|Run Command|
|`-`|Up|
|`>`|Next Sibling|
|`<`|Previous Sibling|
|`B`|Toggle Filter: No Buffer|
|`C`|Toggle Filter: Git Clean|
|`D`|Trash|
|`E`|Expand All|
|`F`|Live Filter: Clear|
|`H`|Toggle Filter: Dotfiles|
|`I`|Toggle Filter: Git Ignore|
|`J`|Last Sibling|
|`K`|First Sibling|
|`M`|Toggle Filter: No Bookmar|
|`O`|Open: No Window Picker|
|`P`|Parent Directory|
|`R`|Refresh|
|`S`|Search|
|`U`|Toggle Filter: Hidden|
|`W`|Collapse|
|`Y`|Copy Relative Path|
|`a`|Create File Or Directory|
|`bd`|Delete Bookmarked|
|`bmv`|Move Bookmarked|
|`bt`|Trash Bookmarked|
|`[c`|Prev Git|
|`c`|Copy|
|`]c`|Next Git|
|`d`|Delete|
|`[e`|Prev Diagnostic|
|`]e`|Next Diagnostic|
|`e`|Rename: Basename|
|`f`|Live Filter: Start|
|`g?`|Help|
|`gy`|Copy Absolute Path|
|`m`|Toggle Bookmark|
|`o`|Open|
|`p`|Paste|
|`q`|Close|
|`r`|Rename|
|`s`|Run System|
|`u`|Rename: Full Path|
|`x`|Cut|
|`y`|Copy Name|

## Debugger
| **Command**  |   **Description**   |
|:------------:|:-------------------:|
| `<leader>tb` | Toggle Break Point  |
| `<leader>dl` |      Open menu      |
| `<leader>tm` | Test nearest method |
| `<leader>tc` |     Test class      |
|     `F5`     |     Run project     |
|     `F7`     |      Step into      |
|     `F8`     |      Step over      |
|     `F9`     |      Step out       |
|    `F10`     |      Run last       |
## Copilot Chat
| **Command** | **Description** |
| :--: | :--: |
| `<leader>cce` | Copilot Chat explain |
| `<leader>cct` | Copilot chat create test |
| `<leader>ccv` | Copilot chat visual* |
| `<leader>ccx` | Copilot chat inplace* |

 **\*** Only on visual mode
