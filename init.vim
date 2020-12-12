:" # Plugins
call plug#begin('~/.vim/plug')
" ## Language Support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Omnisharp/omnisharp-vim' "C# language server
Plug 'rust-lang/rust.vim' " Rust lang syntax highlighting, indent files
Plug 'sheerun/vim-polyglot' " Syntax highlighting + Indent files for many languages
Plug 'junegunn/fzf' " Fuzzy file-search
" ## Theming"
Plug 'joshdick/onedark.vim' " One Dark - use with 'colorsceme onedark'
Plug 'chriskempson/base16-vim' " Base16 color themes
" ## lightline
 Plug 'itchyny/lightline.vim'
call plug#end()
" # Theme
syntax enable
colorscheme base16-material-palenight
set number relativenumber
" # Set color mode to 24-bit
 if exists('+termguicolors')
   let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
   let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
   set t_Co=256
   set termguicolors
 endif
let base16colorspace=256
" ## lightline
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'separator':    { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }
set noshowmode " Hide default -- INSERT -- line
" # Vim configuration
set hidden         " Allow multiple buffers open at onc
set expandtab      " <TAB> inserts spaces, not \t
set softtabstop=2  " <TAB> inserts 4 spaces
set number         " show line numbers
set cursorline     " highlight current line
set wildmenu       " visual autocomplete for command menu
filetype indent on " load filetype-specific indent files
set incsearch      " search as characters are entered
set hlsearch       " highlight matches
" # Filetype Association
autocmd BufReadPost *.rs setlocal filetype=rust
" # Language Client configuration
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ }
" ## Automatically start language servers.
let g:LanguageClient_autoStart = 1
" # Keybinds
" ## Language Client:
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
"  -  Maps `gh` to hover
nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
"  - GOTO definition
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"  - GOTO references
nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
"  - Display err messages in full
nnoremap <silent> <leader>? :call LanguageClient#explainErrorAtPoint()<CR>
nnoremap <silent> <leader>?? :copen<CR>
"  - Display available code actions
nnoremap <silent> ga :call LanguageClient_textDocument_codeAction()<CR>
"  - Rename variable under cursor
nnoremap <F2> :call LanguageClient_textDocument_rename()<CR>
"  - Remap `esc` to `jk`
vnoremap <silent> jk <Esc>
noremap! <silent> jk <Esc>
"  - Fuzzy Finder search from current directory
nnoremap <silent> <leader>f :FZF<CR>
"  - Fuzzy Finder search from home directory
nnoremap <silent> <leader>F :FZF ~<CR>
