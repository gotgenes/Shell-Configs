" BEHAVIORAL SETTINGS

" This is Vim, not VI, so we use it like we mean it!
set nocompatible
" Allow backspacing over anything in insert mode
set backspace=indent,eol,start
" Show (partial) command in status line.
set showcmd
" Show matching brackets.
set showmatch
" Do case insensitive matching
set ignorecase
" Do smart case matching
set smartcase
" Incremental search
"set incsearch
" Search highlighting enabled
set hlsearch
" Automatically save before commands like :next and :make
"set autowrite
" Allow resizing of the window on session restore
set sessionoptions+=resize
" Enable mouse usage (all modes) in terminals
"set mouse=a
" Give popup menus for a right mouse-click
set mousemodel=popup
" Hide buffers when they are not displayed; this prevents warning messages
" about modified buffers when switching between them.
set hidden
" Always show the cursor position
set ruler

" Use the persistent undo feature
" See :h persistent-undo
" NOTE: the directory listed in undodir must exist; Vim will not create this
" directory itself!
set undodir=$HOME/.vimundos
set undofile
" Maximum number of changes that can be undone
set undolevels=1000
" Maximum number lines to save for undo on a buffer reload
set undoreload=10000


" MAPPINGS

" Set the leader
let mapleader = ','

" Easy access keystrokes for editing your Vim configuration
:nnoremap <Leader>svrc :source $MYVIMRC<CR>
:nnoremap <Leader>vrc :e $MYVIMRC<CR>

" Quickly switch buffers
nnoremap <unique> <silent> <leader>nn :bn<CR>
nnoremap <unique> <silent> <leader>pp :bp<CR>
nnoremap <unique> <silent> <leader>bd :bd<CR>

" This moves nicely among unbroken text
nnoremap j gj
nnoremap k gk

" Omni-Completion with Control + X, Control + O is a pain in the ass. Map to
" Control + Space bar
inoremap <C-space> <C-x><C-o>
"
" awesome remapping to open tags in new tab
nnoremap <F2> <C-W>]<C-W>T

" I want to quickly switch to text settings sometimes.
nnoremap <Leader>ts :setlocal ai et sts=4 sw=4 ts=4 tw=78 spell<CR>

" Turn off highlighted search terms
nnoremap <silent> ,/ :nohlsearch<CR>


" SYNTAX HIGHLIGHTING AND COLOR SETTINGS

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax enable

" Uncomment one below to get a dark background or a light background. (NOTE: " it is important to specify this background before specifying any colorscheme
" in Vim. [GVim does not seem phased by the order.])
"set background=light
set background=dark

" Choose a favorite color scheme
if strlen(globpath(&rtp, 'colors/peaksea.vim'))
    colorscheme xoria256
endif


" PROGRAMMING OPTIONS (TODO: move to separate Vim files)

if has("autocmd")
  filetype plugin indent on
  " Start editing from the last edited position in the file.
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
  " This setting makes sure Vim is always operating in the directory of
  " the current buffer
  autocmd BufEnter * lcd %:p:h
  autocmd FileType vim setlocal expandtab smarttab softtabstop=2 shiftwidth=2
  autocmd FileType tex setlocal expandtab smarttab softtabstop=4 shiftwidth=4 tabstop=4 tw=72 spell spelllang=en
  autocmd FileType html,xml,css setlocal autoindent expandtab smarttab softtabstop=2 tabstop=2 shiftwidth=2
  autocmd FileType dot setlocal tabstop=4 shiftwidth=4 tw=78 autoindent
  autocmd FileType Wikipedia setlocal linebreak
  autocmd FileType rst setlocal autoindent expandtab smarttab softtabstop=2 tabstop=2 shiftwidth=2 tw=72

  " If you prefer the Omni-Completion tip window to close when a selection is
  " made, these lines close it on movement in insert mode or when leaving
  " insert mode
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif


" PLUGINS CONFIGURATIONS

" vim-addon-manager support
fun SetupVAM()
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  "   to fetch VAM, VAM-known-repositories and the listed plugins
  "   without having to install curl, unzip, git tool chain first
  if !filereadable(vam_install_path.'/vim-addon-manager/.git/config') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
    " VAM run helptags automatically if you install or update plugins
    exec 'helptags '.fnameescape(vam_install_path.'/vim-addon-manager/doc')
  endif

  call vam#ActivateAddons(['BufOnly', 'EasyMotion', 'LaTeX-Suite_aka_Vim-LaTeX', 'LustyJuggler', 'matchit.zip', 'pylint', 'The_NERD_Commenter', 'trailing-whitespace', 'UltiSnips', 'utl', 'github:gotgenes/vim-yapif', 'virtualenv'], {'auto_install' : 0})
endfun
call SetupVAM()


" utl configuration
let g:utl_cfg_hdl_scm_http_system = "silent !open %u"
nnoremap <unique> <Leader>gu :Utl openLink underCursor edit<CR>
nnoremap <unique> <Leader>cl :Utl copyLink underCursor<CR>

" LaTeX Suite configuration
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to alway generate a file-name.
set grepprg=grep\ -nH\ $*
" LaTeX suite default output
let g:Tex_DefaultTargetFormat = "pdf"
"let g:Tex_ViewRule_dvi = "open"
"let g:Tex_ViewRule_pdf = "open"
"let g:Tex_ViewRule_ps = "open"


" I use NERDCommenter, which complains when it doesn't recognize a
" filetype; this keeps it from bitching.
let NERDShutUp=1


" UltiSnips configuration
let g:UltiSnipsListSnippets = "<S-Tab>"
let g:ultisnips_python_style = "sphinx"


" LustyJuggler
let g:LustyJugglerShowKeys = "a"

function ToggleLustyJugglerLayout()
  if !exists("g:LustyJugglerKeyboardLayout")
    let g:LustyJugglerKeyboardLayout = "dvorak"
  elseif g:LustyJugglerKeyboardLayout != "dvorak"
    let g:LustyJugglerKeyboardLayout = "dvorak"
    echo "LustyJuggler using Dvorak layout."
  else
    let g:LustyJugglerKeyboardLayout = "default"
    echo "LustyJuggler using default layout."
  endif
endfunction

call ToggleLustyJugglerLayout()

nnoremap <silent> <Leader>tlj :call ToggleLustyJugglerLayout()<CR>


" trailing-whitespace configuration
function ToggleAutoRmTrailingWhitespace()
  if !exists("g:auto_rm_trailing_ws")
    let g:auto_rm_trailing_ws = 1
  elseif g:auto_rm_trailing_ws != 1
    let g:auto_rm_trailing_ws = 1
    echo "Automatically removing trailing whitespace."
  else
    let g:auto_rm_trailing_ws = 0
    echo "Not automatically removing trailing whitespace."
  endif
endfunction

call ToggleAutoRmTrailingWhitespace()

nnoremap <silent> <Leader>ttws :call ToggleAutoRmTrailingWhitespace()<CR>

if has("autocmd")
  " Tidy up trailing whitespace when writing the file if we have the
  " trailing-whitespace plugin installed and we've set the proper variable.
  autocmd BufWritePre * if exists(":FixWhitespace") && exists("g:auto_rm_trailing_ws") && g:auto_rm_trailing_ws == 1 | exe ":FixWhitespace" | endif
endif

" pylint.vim configuration
let g:pylint_onwrite = 0

