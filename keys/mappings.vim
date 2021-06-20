" Open vim config
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>

" Search :Files
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<space>

" Tree
nnoremap <c-\> :NERDTreeToggle<cr>

" Comment code
nmap ;; <plug>NERDCommenterToggle
vmap ;; <plug>NERDCommenterToggle

" Open terminal
nnoremap <leader>t :split term://zsh<cr>

" Better window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

