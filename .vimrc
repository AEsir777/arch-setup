" Put your own customizations below
syntax on
set smartcase
set nu rnu
set background=dark
set nowrap
set showcmd
set shortmess-=S
set mouse=n " we only care about being able to scroll around
set encoding=utf-8
set spell
set wildmenu

" Indent 
set shiftwidth=3
set smartindent 
" Copy the indent from prev line unless type nothing or <CTRL-D> and quit
set autoindent
set smarttab
set colorcolumn=85
set textwidth=85
filetype indent on

augroup NoAutoComment
  au!
  au FileType * setlocal formatoptions=cq cinoptions=(s
  au FileType python setlocal indentexpr=
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Setup Vim-PlugIn
set nocompatible          " be iMproved, required
filetype off              " required
filetype plugin indent on " required

" Installing Vim-Plug if it's not available
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Use Vim-Plug in manage plugins
call plug#begin()

" lsp client
Plug 'dense-analysis/ale'

" fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" cosmetic plugins
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

" align text :Tab /<somet char>/position
Plug 'godlygeek/tabular'
" replace surround  cs<before><after>
Plug 'tpope/vim-surround'

" Clipboard
" vim tmux clipboard
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'roxma/vim-tmux-clipboard'
" vim OSC 52 powerful yank 
Plug 'haya14busa/vim-poweryank'

" git
Plug 'airblade/vim-gitgutter'
" vim latex
Plug 'lervag/vimtex'
" This is for snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim latex configuration
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see :help vimtex-compiler.
let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" snippet
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fix color
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors

" color scheme
set noshowmode
colorscheme catppuccin_mocha
" background transparency
hi Normal guibg=NONE ctermbg=NONE
" change comment and line number color
hi Comment guifg=#A1B9D1
hi LineNr guifg=#848B91
hi TabLine guifg=#A7ACB0

" airline
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts=1
let g:lightline = {'colorscheme': 'catppuccin_mocha'}
let g:airline_theme = 'catppuccin_mocha'
let g:airline#extensions#branch#enabled = 1
let g:airline_section_z = "%3p%% %l:%c"
let g:airline#extensions#default#layout = [
\ [ 'a', 'b', 'c' ],
\ [ 'x', 'z' , 'y' ],
\ ['error', 'warning'] ]

set cursorline
hi cursorline cterm=none term=none
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za " fold/unfold with spacebar

" fzf
set rtp+=~/.fzf
nnoremap <C-t> :FZF<CR>

" CSV setup
let g:csv_delim = ','
let g:csv_strict_columns = 1
let g:csv_autocmd_arrange = 1
let g:csv_autocmd_arrange_size = 1024*1024 " Only format csvs < 1MB

" restore cursor to last pos
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command remappings

" sort python imports
command -range=% Pysort :<line1>,<line2> sort /[if][^ ]*/

" Clipboard to pipe into system clipboard 
" vnoremap <C-c> :w !xsel -b<CR><CR>
" nnoremap <C-c> :w !xsel -b<CR><CR>
map <C-c> <Plug>(operator-poweryank-osc52)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General key remappings

" VS code-esque line movement but with ctrl
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" scroll horizontally by half pages
noremap <C-L> zL
noremap <C-H> zH

" paste mode
set pastetoggle=<F3>

" GitGutter toggle
nnoremap <F2> :GitGutterBufferToggle<CR>

" Close previous tab
nnoremap <silent> cp :tabprevious<CR>:tabclose<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale key remappings
nmap <silent> <C-[> <Plug>(ale_previous_wrap)
nmap <silent> <C-]> <Plug>(ale_next_wrap)

nnoremap <silent> gd <Plug>(ale_go_to_definition)<CR>
" TODO: Why this doesn't work ???
nnoremap <silent> gs <Plug>(ale_go_to_definition_in_split)<CR>
nnoremap <silent> gv :ALEGoToDefinition --vsplit<CR>
nnoremap <silent> gb :ALEGoToDefinition --tab<CR>

" --- ALE Hover ---
nnoremap <silent> H :ALEHover<CR>

" Completion
let g:ale_completion_enabled = 1
set completeopt=menu,menuone,preview,noselect,noinsert


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show tab number.
" (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)
if exists("+showtabline")
    function! MyTabLine()
        let s = ''
        let wn = ''
        let t = tabpagenr()
        let i = 1
        while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            let s .= '%' . i . 'T'
            let s .= (i == t ? '%1*' : '%2*')
            let s .= ' '
            let wn = tabpagewinnr(i,'$')

            let s .= '%#TabNum#'
            let s .= i
            " let s .= '%*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let bufnr = buflist[winnr - 1]
            let file = bufname(bufnr)
            let buftype = getbufvar(bufnr, 'buftype')
            if buftype == 'nofile'
                if file =~ '\/.'
                    let file = substitute(file, '.*\/\ze.', '', '')
                endif
            else
                let file = fnamemodify(file, ':p:t')
            endif
            if file == ''
                let file = '[No Name]'
            endif
            let s .= ' ' . file . ' '
            let i = i + 1
        endwhile
        let s .= '%T%#TabLineFill#%='
        let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
    set showtabline=1
    highlight link TabNum Special
endif
