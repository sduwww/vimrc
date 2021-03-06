﻿" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

"------------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
"------------------------------------------------------------------------------

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

let mapleader=";"
let g:mapleader=";"
"==============================================================================
"                          << 以下为软件默认配置 >>
"==============================================================================

"------------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
"------------------------------------------------------------------------------
if (g:iswindows && g:isGUI)

	source $VIMRUNTIME/vimrc_example.vim

	source $VIMRUNTIME/mswin.vim

	behave mswin

endif

"------------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
"------------------------------------------------------------------------------
if !g:iswindows

    set hlsearch        "高亮搜索

    set incsearch       "在输入要搜索的文字时，实时匹配

    " Uncomment the following to have Vim jump to the last position when

    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.

        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.

        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标

        set t_Co=256                   " 在终端启用256色

        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available

        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================
if (g:iswindows && g:isGUI)
    call plug#begin($HOME.'/vimfiles/bundle')
else
    call plug#begin($HOME.'/.vim/vimfiles/bundle')
endif
"  主题
Plug 'gregsexton/Atom'
Plug 'joshdick/onedark.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'

Plug 'jsfaint/gen_tags.vim'

" Plug 'dyng/ctrlsf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'name5566/vim-bookmark'
Plug 'scrooloose/nerdcommenter'
Plug 'b3niup/numbers.vim'

Plug 'scrooloose/nerdtree'

Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/Mark--Karkat'
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/repeat.vim'
Plug 'vim-scripts/std_c.zip'
Plug 'vim-scripts/ZoomWin'
Plug 'vim-scripts/a.vim'

Plug 'majutsushi/tagbar'

Plug 'mbbill/undotree'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

Plug 'dkprice/vim-easygrep'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'

Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'justmao945/vim-clang'

call plug#end()

syntax on
filetype plugin indent on                             " 启用缩进

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码，默认不更改
set fileencoding=utf-8                                  "设置当前文件编码，可以更改，如：gbk（同cp936）
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


"------------------------------------------------------------------------------
"  < 编写文件时的配置 >
"------------------------------------------------------------------------------
set showtabline=1
set nocompatible                                      " 关闭 Vi 兼容模式
filetype on                                           " 启用文件类型侦测
filetype plugin on                                    " 针对不同的文件类型加载对应的插件
set smartindent                                       " 启用智能对齐方式
set expandtab                                         " 将tab键转换为空格
set tabstop=4                                         " 设置tab键的宽度
set shiftwidth=4                                      " 换行时自动缩进4个空格
set smarttab                                          " 指定按一次backspace就删除4个空格
set foldenable                                        " 启用折叠
set foldmethod=indent                                 " 选择代码折叠类型，手工，并用zd来开关折叠
set foldlevel=100                                     " 禁止自动折叠
"set foldmethod=indent                                 " indent 折叠方式
"set relativenumber									  " 相对行号
set whichwrap=b,s,<,>,[,]							  " 让退格、空格、上下箭头遇到行首行尾时自动移到下一行，包括insert模式
set scrolloff=10
"用空格键来开关折叠
nnoremap zd @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 当文件在外部被修改，自动更新该文件
set autoread

"常规模式下输入 cs 清除行尾空格
nmap cs :%s/\s\+$//g<cr>:noh<cr>                      "这三个很有用

"常规模式下输入 cm 清除行尾 ^M 符号
nmap cm :%s/\r$//g<cr>:noh<cr>

"常规模式下输入 ch 取消gd/搜索之后的高亮
nmap ch :nohl<cr>:ccl<cr>

"常规模式下输入 ct 清除tab建，替换为空格
nmap ct :%ret! 4<cr>

"ctrl + shift + up/down 移动当前行位置
nmap <c-s-Down> mz:m+<cr>`z
nmap <c-s-Up> mz:m-2<cr>`z
vmap <c-s-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <c-s-Up> :m'<-2<cr>`>my`<mzgv`yo`z

" swap换行展示时，使用hjkl体验更好
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" 跳转时至于屏幕正中
nmap G Gzz
nmap [[ [[zz
nmap ]] ]]zz

nmap U <c-u>
nmap D <c-d>
nmap <c-u> <c-u>zz
nmap <c-d> <c-d>zz

" 插入模式下jj返回普通模式
imap jj <Esc>

" F9 增加缩进，F10 减少缩进
nmap <Leader>]  >>
nmap <Leader>[ <<
vmap <Leader>]  >
vmap <Leader>[ <
vnoremap < <gv
vnoremap > >gv

" 复制当前行
map Y y$
" 复制选中区到系统剪切板中
vnoremap <Leader>y "+y
nmap <Leader>p "+p
" 搜索时，进入下一个上一个始终放在屏幕中间
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> g* g*zz

" H和L跳转至行首和行末
noremap H ^
noremap L $

" ctrl_\竖向分屏
map <c-\> :vs<CR>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
"set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 保存文件
nmap <Leader>w :w!<CR>
" imap <Leader>w <ESC>:w!<CR>a
vmap <Leader>w <ESC>:w!<CR>

nmap <Leader>wa :wall!<CR>
" imap <Leader>wa <ESC>:wall!<CR>a
vmap <Leader>wa <ESC>:wall!<CR>

nmap <Leader>q :q!<CR>
"设置切换Buffer快捷键"
nnoremap bn :bn<CR>
nnoremap bp :bp<CR>
nnoremap bd :bdelete<CR>  " 关闭当前buffer

if (g:iswindows)
    nmap <Leader>rs :source $HOME/_vimrc<CR>
    nmap <Leader>o :e $HOME/_vimrc<CR>
else
    nmap <Leader>rs :source $HOME/.vimrc<CR>
    nmap <Leader>o :e $HOME/.vimrc<CR>
endif

"每行超过80个的字符用下划线标示
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 180 . 'v.\+', -1)
" let g:deoplete#enable_at_startup = 1
"------------------------------------------------------------------------------
" < 界面配置 >
"------------------------------------------------------------------------------
if has('gui_running')
    au GUIEnter * simalt ~x                              " 窗口启动时自动最大化
    set guioptions-=e
    set guioptions-=T                                     " 隐藏工具栏
    set laststatus=2                                      " 开启状态栏信息
    "set guifont=BitStream_Vera_Sans_Mono:h11              " 设置字体:字号（字体名称空格用下划线代替）
    "set guifont=YaHei_Consolas_Hybrid:h11                 " 设置字体:字号（字体名称空格用下划线代替）
    set guifont=Consolas:h12                               " 设置字体:字号（字体名称空格用下划线代替）
endif
set shortmess=atI                                     " 去掉欢迎界面
set number                                            " 显示行号
set cmdheight=1                                       " 设置命令行的高度为2，默认为1
set cursorline                                        " 突出显示当前行
set nowrap                                            " 设置不自动换行
"winpos 100 20                                         " 指定窗口出现的位置，坐标原点在屏幕左上角
"set lines=45 columns=120                              " 指定窗口大小，lines为高度，columns为宽度
syntax enable                                         " 打开语法高亮
set showmatch                                         " 显示括号配对情况
set hlsearch                                          " 开启高亮显示结果
set hidden                                            " 允许在有未保存的修改时切换缓冲区
set list                                              " 显示Tab符，使用一高亮竖线代替
set listchars=tab:\|\ ,
set ruler                                             " 右下角显示光标位置的状态行
set incsearch                                         " 查找book时，当输入/b时会自动找到
set hlsearch                                          " 开启高亮显示结果
set incsearch                                         " 开启实时搜索功能
set nowrapscan                                        " 搜索到文件两端时不重新搜索
set nocompatible                                      " 关闭兼容模式
" For Haskell
:let hs_highlight_delimiters=1                        " 高亮定界符
:let hs_highlight_boolean=1                           " 把True和False识别为关键字
:let hs_highlight_types=1                             " 把基本类型的名字识别为关键字
:let hs_highlight_more_types=1                        " 把更多常用类型识别为关键字
:let hs_highlight_debug=1                             " 高亮调试函数的名字
:let hs_allow_hash_operator=1                         " 阻止把#高亮为错误

" 设置代码配色方案
if g:isGUI
    "set background=dark
    "colorscheme darkblue                              "Gvim配色方案
    " colorscheme gruvbox
    colorscheme onedark
else
    let g:rehash256 = 1
    set background=dark
    " colorscheme gruvbox                               "终端配色方案
    colorscheme onedark                               "终端配色方案
endif

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

"------------------------------------------------------------------------------
"  < 其它配置 >
"------------------------------------------------------------------------------



" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>kzz
noremap <c-j> <c-w>jzz
noremap <c-h> <c-w>hzz
noremap <c-l> <c-w>lzz
" 关闭当前窗口
noremap <c-w> :close<cr>

" -----------------------------------------------------------------------------
"  < ZoomWin 插件配置 >
" -----------------------------------------------------------------------------
" 用于分割窗口的最大化与还原
" 常规模式下按快捷键 <c-w>o 在最大化与还原间切换

" -----------------------------------------------------------------------------
"  < gen_tags 配置 >
" -----------------------------------------------------------------------------
if (g:iswindows)
    let g:gen_tags#ctags_bin = $HOME.'/bin/ctags.exe'
else
    let g:gen_tags#ctags_bin = '/usr/bin/ctags'
endif
let g:gen_tags#use_cache_dir = 1
let g:gen_tags#verbose=0
" 用Ctags生成标签
let g:gen_tags#ctags_auto_gen = 1
let g:loaded_gentags#gtags = 1
let g:gen_tags#ctags_opts = '--c++-kinds=+p --fields=+iaS --extra=+q -a'    "ctags增量标签
let g:gen_tags#ctags_prune = 1  " 增量前删除旧的
" let g:gen_tags#blacklist = ['$HOME']
"autocmd BufWritePost * :GenCtags

" 用Gtags生成标签
" let g:gen_tags#gtags_auto_gen = 1
" let g:gen_tags#gtags_split = 'v'
" let g:loaded_gentags#ctags = 1
" set cscopetag
" set cscopeprg='gtags-cscope'

" Ctrl+\ c    Find functions calling this function
" Ctrl+\ d    Find functions called by this function
" Ctrl+\ e    Find this egrep pattern
" Ctrl+\ f    Find this file
" Ctrl+\ g    Find this definition
" Ctrl+\ i    Find files #including this file
" Ctrl+\ s    Find this C symbol
" Ctrl+\ t    Find this text string
" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

"------------------------------------------------------------------------------
"  < DoxygenToolKit.vim 插件配置 >
" -- 自动添加函数注释
"------------------------------------------------------------------------------
let g:DoxygenToolkit_briefTag_pre="@Breif:  "
let g:DoxygenToolkit_paramTag_pre="@Param:  "
let g:DoxygenToolkit_returnTag="@Return:  "
let g:DoxygenToolkit_authorName="sduwww"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
nmap <Leader>fd <ESC>:Dox<cr>

" -----------------------------------------------------------------------------
"  < emmet-vim（前身为Zen coding） 插件配置 >
" -----------------------------------------------------------------------------
" HTML/CSS代码快速编写神器，详细帮助见 :h emmet.txt

" -----------------------------------------------------------------------------
"  < undotree 插件配置 >
" -----------------------------------------------------------------------------
if has("persistent_undo")
    set undodir=$HOME.'/.cache/undo_dir/'
    set undofile
endif

let g:undotree_WindowLayout=1
let g:undotree_CustomUndotreeCmd = 'vertical 32 new'
let g:undotree_CustomDiffpanelCmd= 'belowright 12 new'
let g:undotree_ShortIndicators=1
" function g:Undotree_CustomMap()
    " nmap <buffer> J <plug>UndotreeGoNextState
    " nmap <buffer> K <plug>UndotreeGoPreviousState
" endfunc
nmap <Leader>z :UndotreeToggle<cr>

" -----------------------------------------------------------------------------
"  < numbers 插件配置 >
" -----------------------------------------------------------------------------
" nnoremap tn :NumbersToggle<CR> 		" 切换行号显示模式
" -----------------------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -----------------------------------------------------------------------------
" set completeopt=menu,menuone
" let OmniCpp_MayCompleteDot=1        " 打开  . 操作符
" let OmniCpp_MayCompleteArrow=1      " 打开 -> 操作符
" let OmniCpp_MayCompleteScope=1      " 打开 :: 操作符
" let OmniCpp_NamespaceSearch=1       " 打开命名空间
" let OmniCpp_GlobalScopeSearch=1
" let OmniCpp_DefaultNamespace=["std"]
" let OmniCpp_ShowPrototypeInAbbr=1   " 打开显示函数原型
" let OmniCpp_SelectFirstItem = 2     " 自动弹出时自动跳至第一个

" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt

" -----------------------------------------------------------------------------
"  < a.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口
" nnoremap <silent> <A-o> :A <CR>

" -----------------------------------------------------------------------------
"  < auto-pairs 插件配置 >
" -----------------------------------------------------------------------------
" 用于括号与引号自动补全，不过会与函数原型提示插件echofunc冲突

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

let NERDTreeWinPos=1
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=31
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略以下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
"打开文件时关闭树
let NERDTreeQuitOnOpen=1

" ctrl-b 打开文件浏览
map <silent> <c-b> :NERDTreeFind<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" -----------------------------------------------------------------------------
"  < ctrlp.vim 插件配置 >
" -----------------------------------------------------------------------------
" 一个全路径模糊文件，缓冲区，最近最多使用，... 检索插件；详细帮助见 :h ctrlp

let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

nnoremap <Leader>f :CtrlpFunky<CR>
let g:ctrlp_extensions = ['funky']
" -----------------------------------------------------------------------------
"  < tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等

" 相对 TagList 能更好的支持面向对象
" 常规模式下输入 ctrl - r 调用插件，如果有打开 TagList 窗口则先将其关闭
nmap <silent> <c-r> :TagbarOpenAutoClose<CR>

if (g:iswindows)
    let g:tagbar_ctags_bin = $HOME.'/bin/ctags.exe'
else
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
endif

let g:tagbar_width=30                       "设置窗口宽度
let g:tagbar_left=1                         "在左侧窗口中显示
let g:tagbar_autofocus=1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_systemenc = 'cp936'


" -----------------------------------------------------------------------------
"  < Mark--Karkat（也就是 Mark） 插件配置 >
" -----------------------------------------------------------------------------
" 给不同的单词高亮，表明不同的变量时很有用，详细帮助见 :h mark.txt
let g:mwAutoLoadMarks = 1
" <Leader>m     " Mark the word under the cursor, If already on a mark: Clear the mark
" <Leader>*     " Jump to the next occurrence of last mark
" <Leader>/     " Jump to the next occurrence of ANY mark


" -----------------------------------------------------------------------------
"  < gvimfullscreen 工具配置 > 请确保已安装了工具
" -----------------------------------------------------------------------------
" 用于 Windows Gvim 全屏窗口，可用 F11 切换
" 全屏后再隐藏菜单栏、工具栏、滚动条效果更好
if (g:iswindows && g:isGUI)
    nmap <F11> <Esc>:call libcallnr($HOME."/bin/gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif

" -----------------------------------------------------------------------------
"  < vimtweak 工具配置 > 请确保以已装了工具
" -----------------------------------------------------------------------------
" 这里只用于窗口透明与置顶
" 常规模式下 Ctrl + Up（上方向键） 增加不透明度，Ctrl + Down（下方向键） 减少不透明度，<Leader>t 窗口置顶与否切换
if (g:iswindows && g:isGUI)
    let g:Current_Alpha = 255
    let g:Top_Most = 0
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr($HOME."/bin/vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr($HOME."/bin/vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr($HOME."/bin/vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr($HOME."/bin/vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

    "快捷键设置
    nmap <c-up> :call Alpha_add()<CR>
    nmap <c-down> :call Alpha_sub()<CR>
    nmap <leader>t :call Top_window()<CR>
endif


" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 0
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 0
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

nmap <Leader>c <plug>NERDCommenterInvert
vmap <Leader>c <plug>NERDCommenterInvert
" -----------------------------------------------------------------------------
"  < repeat 插件配置 >
" -----------------------------------------------------------------------------
" 主要用"."命令来重复上次插件使用的命令


" -----------------------------------------------------------------------------
"  < std_c 插件配置 >
" -----------------------------------------------------------------------------
" 主要用于高亮c/c++文件
let c_cpp_comments = 1

" -----------------------------------------------------------------------------
"  < EasyGrep 插件配置 >
" -----------------------------------------------------------------------------
let g:EasyGrepMode = 2     " All:0, Open Buffers:1, TrackExt:2,
let g:EasyGrepCommand = 0  " Use vimgrep:0, grepprg:1
let g:EasyGrepRecursive  = 1 " Recursive searching
let g:EasyGrepIgnoreCase = 1 " not ignorecase:0
let g:EasyGrepFilesToExclude = "*.bak,*~,cscope.*,*.a,*.o,*.pyc,*.bak,.svn,.git,*.swp"
" <Leader>vv or :Grep: \vv命令将在文件中搜索当前光标下的单词, :Grep word将搜索"word", 如果加叹号:Grep !word表示全词匹配的方式搜索, Grep也可以带参数, 比如:Grep -ir word, r表示递归目录. i表示不区分大小写.
" <Leader>vV : 全词匹配搜索, 同:Grep !word;
" <Leader>va : 与vv相似, 搜索结果append在上次搜索结果之后;
" <Leader>vA : 与vV相似, 搜索结果append在上次搜索结果之后;
" <Leader>vr or :Replace :替换;
" <Leader>vo or :GrepOptions: 打开选项菜单;
map <silent> <c-f> <plug>EgMapGrepCurrentWord_v

" -----------------------------------------------------------------------------
"  < multi_cursor 插件配置 >
" -----------------------------------------------------------------------------
" 进入v模式后选中单词进行操作，I进行更改，esc退出
let g:multi_cursor_use_default_mapping=0

" user mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" -----------------------------------------------------------------------------
"  < expand_region 插件配置 >
" -----------------------------------------------------------------------------
" let g:expand_region_use_select_mode = 1
map ++ <Plug>(expand_region_expand)
map __ <Plug>(expand_region_shrink)



" -----------------------------------------------------------------------------
"  < lightline and lightline-buffer 插件配置 >
" -----------------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ ['lineinfo'], ['percent'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

set showtabline=2
set laststatus=2
set noshowmode
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_map = { 0: '₀', 1: '₁', 2: '₂', 3: '₃', 4: '₄', 5: '₅', 6: '₆', 7: '₇', 8: '₈', 9: '₉'}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" -----------------------------------------------------------------------------
"  <vim-clang 插件配置 >
" ----------------------------------------------------------------------------- 
if (g:iswindows)
    let g:clang_exec = $HOME.'\bin\clang.exe'
endif
let g:clang_c_options = '-std=gnu11 -Wno-incompatible-library-redeclaration -Wno-builtin-requires-header -Wno-visibility'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++ -Wno-incompatible-library-redeclaration -Wno-builtin-requires-header -Wno-visibility'
let g:clang_diagsopt = ''

" -----------------------------------------------------------------------------
"  <gitgutter 插件配置 >
" ----------------------------------------------------------------------------- 
let g:gitgutter_map_keys = 0
if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
let g:gitgutter_max_signs = 5000  " default value
" =============================================================================
"                          << 以下为常用自动命令配置 >>
" =============================================================================
set noundofile
set nowb
set nobackup                                " 设置无备份文件
set autochdir                               " 设定文件浏览器目录为当前目录
set noswapfile                              " 设置无临时文件
set vb t_vb=                                " 关闭提示音
set nocp


" =============================================================================
"                          << 其它 >>
" =============================================================================



