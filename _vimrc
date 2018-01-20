source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"打开语法高亮
syntax on

"配色方案
"colorscheme desert

"文件类型检测
filetype on

"不同文件不同缩进
filetype indent on

"允许使用插件
filetype plugin on
filetype plugin indent on

"关闭vi模式
set nocp

"与windows共享剪贴板
set clipboard+=unnamed

"取消vi兼容
set nocompatible

"显示行号
set nu

"历史命令保存行数
set history=100

"当文件被改变时自动更新
set autoread

"取消自动备份及产生swp文件
set nobackup
set nowb
set noswapfile

"允许鼠标点击定位
set mouse=a

"允许区域选择
set selection=exclusive
set selectmode=mouse,key

"高亮光标所在行
set cursorline

"取消光标闪烁
set novisualbell

"总是显示状态行
set laststatus=2

"状态栏显示执行当前的命令
set showcmd

"显示当前光标所在行列号
set ruler

"设置命令行高度为3
set cmdheight=2

"粘贴时保持格式
set paste

"高亮显示匹配的括号
set showmatch

"搜索时忽略大小写
set ignorecase

"高亮被搜索的句子
set hlsearch

"搜索时，输入的字符逐个高亮
set incsearch

"继承前一行的缩进方式
set autoindent

"为C程序提供自动缩进
set smartindent

"使用C样式的缩进
set cindent

"制表符为4
set tabstop=4

"统一缩进为4
set softtabstop=4
set shiftwidth=4

"允许使用退格键
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"取消换行
"set nowrap

"启动时不显示援助乌干达儿童的提示
set shortmess=atI

"在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

"光标移动到buffer顶部、底部时保持3行距离
set scrolloff=3

"设定默认解码
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

"设定字体
set guifont=Courier_New:h11:cANSI
"set guifontwide=新宋体:h11:cGB2312

"设定编码  
set enc=utf-8  
set fileencodings=ucs-bom,utf-8,chinese  
set langmenu=zh_CN.UTF-8  
language message zh_CN.UTF-8  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
  
"自动补全  
filetype plugin indent on  
set completeopt=longest,menu  
  
"自动补全命令时候使用菜单式匹配列表  
set wildmenu  
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete  
autocmd FileType python set omnifunc=pythoncomplete#Complete  
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS  
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags  
autocmd FileType css set omnifunc=csscomplete#CompleteCSS  
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags  
autocmd FileType java set omnifunc=javacomplete#Complet
