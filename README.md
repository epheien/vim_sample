# vim_sample
sample config for vim

## 包含的插件
* pathogen
* nerdtree
* mark
* tagbar
* vimcdoc
* vim-signature
* asynccompl
* videm
* escalt
* jsonfmtr

## 杂项
* c.vim

## 依赖
* vim (+cscope +netbeans_intg +python)
* ctags
* cscope
* gun global
* python 2.6+

## 常规键位绑定
    <C-h>       把光标向左移动一个窗口
    <C-l>       把光标向右移动一个窗口
    <C-k>       把光标向上移动一个窗口
    <C-j>       把光标向下移动一个窗口
    
    \m          高亮/取消高亮光标所在单词
    \c          取消所有单词的高亮
    \*          跳到下一个相同的高亮单词
    \/          跳到下一个高亮单词
    *           跳到下一个(相同的)高亮单词, 视乎之前使用的是 \* 还是 \/
    
    m,          在当前行打上书签
    m[a-zA-Z]   在当前行切换书签
    ]'          跳转到下一个书签
    ['          跳转到上一个书签

## cscope的键位绑定
    <C-]>       跳转到光标所在的 C 符号的定义
    <C-t>       返回上一次跳转的位置
    T           <C-t>的逆动作
    <C-\>s      查找光标所在的 C 符号的所有引用
    <C-\>c      查找光标所在的 C 函数的所有调用

## videm简易使用说明
    :VidemOpen                          打开 videm 界面
    .                                   弹出式菜单, 内容取决于光标所在的位置
    :VSearchSymbolReference {符号名称}  搜索符号的所有引用
    :VSearchSymbolCalling   {符号名称}  搜索符号的所有调用
