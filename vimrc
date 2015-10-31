" stub for test
let s:file = expand('<sfile>')
let s:dir = fnamemodify(s:file, ':h')
set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
exec 'set runtimepath^=' . fnameescape(s:dir) . '/dotvim'
exec 'set runtimepath+=' . fnameescape(s:dir) . '/dotvim/after'

function s:IsUnixOS() "{{{
    if has('win16') || has('win32') || has('win64')
        return 0
    else
        return 1
    endif
endfunction
"}}}
" ============================================================================
" 基本设定
" ============================================================================
" 关闭 vi 兼容模式，否则无法使用 vim 的大部分扩展功能
set nocompatible
" 让退格键以现代化的方式工作
set backspace=2
" 在 vim 窗口右下角，标尺的右边显示未完成的命令
set showcmd
" 增强的命令行补全
set wildmenu
" 左下角显示当前模式
set showmode
" 显示行号
set number
" 打开语法高亮
syntax on
" 打开文件类型的检测
filetype on
" 可以为特定的文件类型允许插件文件的载入
filetype plugin on
" 可以为特定的文件类型载入缩进文件
filetype indent on
" 设定文件编码类型，彻底解决中文编码问题
let &termencoding=&encoding
set fileencodings=utf-8,gbk,gb18030,ucs-bom,cp936
" 为键码打开超时, 避免终端下 <ESC> 的等待
set ttimeout
" 等待键码超时时间
set ttimeoutlen=50
" 搜索时忽略大小写
set ignorecase
" 如果搜索模式包含大写字符，不使用 'ignorecase' 选项
set smartcase
" 设置搜索结果高亮显示
set hlsearch
" 在搜索模式时输入时即时显示相应的匹配点
set incsearch
" 启动对鼠标的支持
set mouse=a
" 鼠标右键弹出菜单
set mousemodel=popup
" 允许光标移动到刚刚超过行尾字符之后的位置, 允许可视列块模式的虚拟编辑
set virtualedit=onemore,block
" 显示 80 字符右边距的实现，需要 7.3 以上版本
if version >= 703 | set cc=81 | endif
" 使新行缩进与前一行一样
set autoindent
" 删除环境变量 LANGUAGE，不然会影响某些插件无法提取英文环境下的命令输出
"let $LANGUAGE=''

" NOTE: 很重要的缩进设置, 根据需要自己设置!
"set tabstop=4      " 历史上, <Tab> 是 8 个空白
set softtabstop=4   " 避免修改 tabstop, 详见 :h 'sts'
set shiftwidth=4    " (自动) 缩进每一步使用的空白数目
set expandtab       " 插入模式里: 插入 <Tab> 时使用合适数量的空格

" 补全菜单的弹出方式, 常用的方式
set completeopt=menuone

" 配色方案
if has('gui_running')   " gui 的情况下
    colorscheme desertEx
elseif &t_Co == 256     " 支持 256 色的话
    colorscheme desertEx256
elseif $TERM ==# "xterm"
    colorscheme default
else
    colorscheme default
endif

" 摘录自 vimrc, sample by Bram
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
augroup Epheien
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif
augroup End

if s:IsUnixOS()
    " 让鼠标右键菜单行为与Windows平台一致
    noremap <RightMouse> <Nop>
    noremap <RightRelease> <RightMouse>
    noremap! <RightMouse> <Nop>
    noremap! <RightRelease> <RightMouse>
    " 不用鼠标左键 3、4 连击
    noremap <3-LeftMouse> <Nop>
    noremap! <3-LeftMouse> <Nop>
    noremap <4-LeftMouse> <Nop>
    noremap! <4-LeftMouse> <Nop>
endif

" ========== cscope 设置 ==========
if has("cscope")
    set cscopeverbose
    set cscopetagorder=0
    set cscopetag
    set cscopequickfix=s-,c-,d-,i-,t-,e-

    " cscope 常用键位绑定
    nnoremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nnoremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nnoremap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nnoremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    function! s:CscopeAdd(name) "{{{
        let prepath = fnamemodify(a:name, ':p:h')
        exec printf('cs add %s %s', fnameescape(a:name), fnameescape(prepath))
    endf
    "}}}
    command! -complete=file -nargs=1 CsAdd :call <SID>CscopeAdd("<args>")
endif


" ============================================================================
" 常规键盘映射
" ============================================================================
" 简易的窗口移动键位绑定, 常用, 够用
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 命令行太常用, : 不好按, 把 ; 映射成 :
nnoremap ; :

" <C-t> 的逆动作
nnoremap T :tag<CR>

" ============================================================================
" 插件设置
" ============================================================================
" ========== pathogen ==========
" init pathogen, 最早貌似只能放到这里, autoload 载入比较迟?
call pathogen#infect()

" ========== matchparen ==========
" vim 的语法高亮效率较低, 在插入模式编辑时高亮匹配的括号时会导致性能问题, 关掉
let matchparen_noinsert = 1

" ========== mark ==========
" mark 不忽略大小写匹配
let g:mwIgnoreCase = 0
" mark 不修改历史
let g:mwHistAdd = ''
" 我们至少使用了256色, 需要较多的高亮组
"let g:mwDefaultHighlightingPalette = 'extended'
" 清除所有 mark 高亮
nnoremap <silent> <Leader>c :MarkClear<CR>

" ========== NERDTree ==========
hi link NERDTreeDir Statement
hi link NERDTreeCWD Type

" ========== tagbar ==========
let g:tagbar_compact = 1
let g:tagbar_width = 30

" ========== asynccompl ==========
" 反注释下面的语句将会禁用 asynccompl
"let g:asynccompl_autostart_filetype = []

" ========== videm ==========
let g:videm_user_options = {
    \ '.videm.Compatible'                   : 0,
    \ '.videm.wsp.ShowBriefHelp'            : 1,
    \ '.videm.wsp.keybind.PopupMenu'        : '<RightRelease>',
    \ '.videm.wsp.LinkToEditor'             : 0,
    \ '.videm.wsp.SaveBeforeBuild'          : 1,
    \
    \ '.videm.common.calltips.IndicateArgument' : 0,
    \ '.videm.common.calltips.EnableSyntaxTest' : 0,
    \
    \ '.videm.cc.omnicpp.UseLibCxxParser'       : 1,
    \ '.videm.cc.omnicpp.InclAllCondCmplBrch'   : 1,
    \
    \ '.videm.dbg.pyclewn.DisableNeedlessTools' : 0,
    \ '.videm.dbg.pyclewn.SaveBpInfo'           : 1,
\ }
"let g:videm_user_options['.videm.wsp.AutoSession'] = 1
let g:videm_user_options['.videm.cc.omnicpp.ItemSelectMode'] = 2
let g:videm_user_options['.videm.symdb.Current'] = "gtags"
let g:videm_user_options['.videm.cc.Current'] = ""
"call filter(g:asynccompl_autostop_filetype, 'v:val !=# "c" && v:val !=# "cpp"')
" 下面这几个选项需要同时设置或同时不设置
" 其中 .videm.cc.Current 可以为 omnicpp, omnicxx, vimccc
"let g:videm_user_options['.videm.cc.Current'] = "vimccc"
"let g:asynccompl_autostop_filetype = ['c', 'cpp']

" ========== VIMCCC ==========
let g:VIMCCC_Enable = 0
let g:VIMCCC_ItemSelectionMode = 2
let g:VIMCCC_CompleteMacros = 1
" for debian 7 x86_64
if filereadable('/usr/lib/libclang.so.1')
    let g:VIMCCC_ClangLibraryPath = '/usr/lib/libclang.so.1'
endif

" ----------------------------------------------------------------------------
" vim: fdm=marker fen fdl=0 et sts=4
