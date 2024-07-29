"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Vundle is short for Vim bundle and is a Vim plugin manager.
" https://github.com/VundleVim/Vundle.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
"-------------- PLUGINS STARTS -----------------
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-scripts/taglist.vim'
Plugin 'wesleyche/Trinity'
Plugin 'wesleyche/SrcExpl'
Plugin 'majutsushi/tagbar'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'junegunn/vim-easy-align'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
"-------------- PLUGINS END --------------------
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" start my vim config
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set bs=indent,eol,start         " allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=100          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
       cs add $CSCOPE_DB/cscope.out
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
set cindent
set smartindent
set autoindent
set report=0
"set selection=exclusive
"set whichwrap+=h,l,b,s,<,>,[,]

" my settings
set mouse=a
set selectmode=mouse,key
set mouse=nv
set autochdir
set tags=$CSCOPE_DB/tags;$HOME
set t_Co=256
set nu
set splitright
set splitbelow
" 
hi Search cterm=reverse ctermbg=none ctermfg=none

set cscopetag
set csto=0
set cscopeverbose
nmap zs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap zg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap zc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap zt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap ze :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap zf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap zi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap zd :cs find d <C-R>=expand("<cword>")<CR><CR>
map <F5> :!csdb_update <CR>:cs reset<CR><CR>   

"只针对特定类型文件自动开启空格和 tab 字符可见
" 创建一个新的 MyTabSpace 组,并设置它的颜色
highlight MyTabSpace guifg=darkgrey ctermfg=darkgrey
" 指定tab字符和空格的颜色组为MyTabSpace,不同字符串之间用|隔开,要使用\|转义.
match MyTabSpace /\t\| /
" 针对特定类型的代码文件,设置显示Tab键和行尾空格以便在查看代码时注意到它们
autocmd FileType perl,sh,conf,kconfig,cmake,make,markdown,c,cpp,java,xml,go,asm setlocal list | set listchars=tab:>-,trail:. | set lcs+=space:·

" To disable Control-a triggering default vim auto-increment on a number
map <C-a> <Nop>
map <C-x> <Nop>

