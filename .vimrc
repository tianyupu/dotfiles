" Set utf8 as encoding
set encoding=utf8

" Rolodex Vim
"set noequalalways winminheight=0 winheight=9999 helpheight=9999

" Set to auto read when a file has been changed externally
set autoread

" Set relative line numbering
set rnu

" Set vim to be clickable (for convenience)
set mouse=a

" Set automatic folding when file is opened
set foldmethod=indent

" Set search highlighting
set hlsearch
" Set ignore case when searching
set ignorecase
" Visual mode: pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Set regular expressions
set magic

" Show matching brackets when text indicator is over them
set showmatch

" Set whitespace and indentation settings
set tabstop=2
set softtabstop=2
set smartindent
set autoindent
set expandtab
set shiftwidth=2

" Always show current position
set ruler

" Always show the status line
set laststatus=2
set showtabline=2
set noshowmode
" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L\ \ \ Col:\ %c

" For 'proper' copying and pasting!
set clipboard=unnamedplus

" Enable syntax highlighting
syntax enable
" ANTLR syntax highlighting
au BufRead,BufNewFile *.g set syntax=antlr3

" Solarized
set background=dark
colorscheme solarized

" Helper functions
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
