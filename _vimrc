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

"���﷨����
syntax on

"��ɫ����
"colorscheme desert

"�ļ����ͼ��
filetype on

"��ͬ�ļ���ͬ����
filetype indent on

"����ʹ�ò��
filetype plugin on
filetype plugin indent on

"�ر�viģʽ
set nocp

"��windows���������
set clipboard+=unnamed

"ȡ��vi����
set nocompatible

"��ʾ�к�
set nu

"��ʷ���������
set history=100

"���ļ����ı�ʱ�Զ�����
set autoread

"ȡ���Զ����ݼ�����swp�ļ�
set nobackup
set nowb
set noswapfile

"�����������λ
set mouse=a

"��������ѡ��
set selection=exclusive
set selectmode=mouse,key

"�������������
set cursorline

"ȡ�������˸
set novisualbell

"������ʾ״̬��
set laststatus=2

"״̬����ʾִ�е�ǰ������
set showcmd

"��ʾ��ǰ����������к�
set ruler

"���������и߶�Ϊ3
set cmdheight=2

"ճ��ʱ���ָ�ʽ
set paste

"������ʾƥ�������
set showmatch

"����ʱ���Դ�Сд
set ignorecase

"�����������ľ���
set hlsearch

"����ʱ��������ַ��������
set incsearch

"�̳�ǰһ�е�������ʽ
set autoindent

"ΪC�����ṩ�Զ�����
set smartindent

"ʹ��C��ʽ������
set cindent

"�Ʊ��Ϊ4
set tabstop=4

"ͳһ����Ϊ4
set softtabstop=4
set shiftwidth=4

"����ʹ���˸��
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

"ȡ������
"set nowrap

"����ʱ����ʾԮ���ڸɴ��ͯ����ʾ
set shortmess=atI

"�ڱ��ָ�Ĵ��ڼ���ʾ�հף������Ķ�
set fillchars=vert:\ ,stl:\ ,stlnc:\

"����ƶ���buffer�������ײ�ʱ����3�о���
set scrolloff=3

"�趨Ĭ�Ͻ���
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

"�趨����
set guifont=Courier_New:h11:cANSI
"set guifontwide=������:h11:cGB2312

"�趨����  
set enc=utf-8  
set fileencodings=ucs-bom,utf-8,chinese  
set langmenu=zh_CN.UTF-8  
language message zh_CN.UTF-8  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
  
"�Զ���ȫ  
filetype plugin indent on  
set completeopt=longest,menu  
  
"�Զ���ȫ����ʱ��ʹ�ò˵�ʽƥ���б�  
set wildmenu  
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete  
autocmd FileType python set omnifunc=pythoncomplete#Complete  
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS  
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags  
autocmd FileType css set omnifunc=csscomplete#CompleteCSS  
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags  
autocmd FileType java set omnifunc=javacomplete#Complet
