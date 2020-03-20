call plug#begin('~/.vim/plugged')

"basic基本设置{
    Plug 'tpope/vim-sensible'
    let g:mapleader=","        " 定义快捷键的前缀，即<Leader>
    noremap <silent> <leader>q :cclose<cr> " 关闭quickfix
    "set autochdir             " 自动设置当前目录为正在编辑的目录
    set binary                 " show \r
    set mouse=a                " 鼠标支持
    set matchtime=1            " 匹配括号高亮的时间（单位是十分之一秒）
    set helplang=cn            " 中文文档
    set nu                     " 显示行号
    set cc=85                  " 显示n个字符竖线
    set nojoinspaces           " 用J命令合并两行时会用一个空格来分隔
    set fileencodings=utf-8    " 文件编码设置
    set hidden                 " Switch between buffers without having to save first.
    set display=lastline       " Show as much as possible of the last line.
    set ttyfast                " Faster redrawing.
    set lazyredraw             " Only redraw when necessary.
    set splitbelow             " Open new windows below the current window.
    set splitright             " Open new windows right of the current window.
    "set cursorline            " Find the current line quickly.
    set wrapscan               " Searches wrap around end-of-file.
    set wrap                   " 控制长行是否折到下一行显示
    set report=0               " Always report changed lines.
    set synmaxcol=80           " Only highlight the first n columns.
    set list                   " Show non-printable characters.
    set listchars=tab:▸\ ,trail:·,precedes:←,extends:→,nbsp:␣ ",space:·
    hi NonText ctermfg=239
    hi SpecialKey ctermfg=239

    "autocmd InsertLeave * se nocul  " 用浅色高亮当前插入行
    "autocmd InsertEnter * se cul    " 用浅色高亮当前插入行
    "set cursorcolumn                " or set cuc 设置光标所在的列
    "highlight CursorColumn cterm=NONE ctermbg=blue ctermfg=NONE guibg=NONE guifg=NONE
    "set cursorline                  " or set cul 设置光标所在的行
    highlight CursorLine cterm=NONE ctermbg=blue ctermfg=NONE guibg=NONE guifg=NONE

    " Put all temporary files under the same directory.
    let s:vim_backup = expand("$HOME/.vim/files/backup/")
    if !isdirectory(s:vim_backup)
        silent! call mkdir(s:vim_backup, 'p')
    endif
    let s:vim_swap = expand("$HOME/.vim/files/swap/")
    if !isdirectory(s:vim_swap)
        silent! call mkdir(s:vim_swap, 'p')
    endif
    let s:vim_undo = expand("$HOME/.vim/files/undo/")
    if !isdirectory(s:vim_undo)
        silent! call mkdir(s:vim_undo, 'p')
    endif
    let s:vim_info = expand("$HOME/.vim/files/info/")
    if !isdirectory(s:vim_info)
        silent! call mkdir(s:vim_info, 'p')
    endif
    set backup
    set backupdir=$HOME/.vim/files/backup/
    set backupext=-vimbackup
    set backupskip=
    set directory=$HOME/.vim/files/swap/
    set updatecount=100
    set undofile
    set undodir=$HOME/.vim/files/undo/
    set viminfo='100,n$HOME/.vim/files/info/viminfo
"}

"底部状态{
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='light'
"}

"tags符号索引{
    Plug 'vim-scripts/gtags.vim'
    Plug 'vim-scripts/autopreview'
    Plug 'vim-scripts/genutils'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'

    set cscopeprg='gtags-cscope'
    set tags=./.tags;.tags
    let $GTAGSLABEL = 'native-pygments'
    " let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'
    " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'
    " 同时开启 ctags 和 gtags 支持
    let g:gutentags_modules = []
    if executable('ctags')
        let g:gutentags_modules += ['ctags']
    endif
    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif
    " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    " 检测 ~/.cache/tags 不存在就新建
    if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
    endif
    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    " 如果使用 universal ctags 需要增加下面一行
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
    " forbid gutentags adding gtags databases
    let g:gutentags_auto_add_gtags_cscope = 0
    " change focus to quickfix window after search (optional)
    let g:gutentags_plus_switch = 1
    let g:gutentags_define_advanced_commands = 1
    let g:gutentags_generate_on_empty_buffer = 1  " open database
    " let g:gutentags_trace = 1

    Plug 'skywind3000/vim-preview'
    "P 预览 大p关闭
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
    noremap <Leader>u :PreviewScroll -1<cr>     " 往上滚动预览窗口
    noremap <leader>d :PreviewScroll +1<cr>     " 往下滚动预览窗口
    noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
    noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
    noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
    noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
    noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
    noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
    noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
"}

"aysncrun编译运行{
    Plug 'skywind3000/asyncrun.vim'
    " asyncrun 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归。
    " 如果递归到根目录还没找到，那么文件所在目录就被当作项目目录。
    let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
    " 自动打开 quickfix window ，高度为 6
    let g:asyncrun_open = 6
    " 任务结束时候响铃提醒
    let g:asyncrun_bell = 1
    " 设置 F10 打开/关闭 Quickfix 窗口
    "nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
    " 设置 F7 从工程根目录编译整个工程
    "nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
"}

"ALE代码检查{
    Plug 'w0rp/ale'
    let g:ale_linters_explicit = 1
    let g:ale_linters = {
      \   'csh': ['shell'],
      \   'zsh': ['shell'],
      \   'go': ['gofmt', 'golint'],
      \   'python': ['flake8', 'mypy', 'pylint'],
      \   'c': ['gcc', 'cppcheck'],
      \   'cpp': ['gcc', 'cppcheck'],
      \   'text': [],
      \}
    let g:ale_completion_delay = 500
    let g:ale_echo_delay = 20
    let g:ale_lint_delay = 500
    let g:ale_echo_msg_format = '[%linter%] %code: %%s'
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:airline#extensions#ale#enabled = 1
    let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
    let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
    let g:ale_c_cppcheck_options = ''
    let g:ale_cpp_cppcheck_options = ''
"}

"vim-signify修改比较{
    Plug 'mhinz/vim-signify'
    let g:signify_vcs_list = [ 'git' ]
    let g:signify_sign_show_text = 1
"}

"vim-cpp-enhanced-highlight语法高亮{
    Plug 'octol/vim-cpp-enhanced-highlight'
    let c_no_curly_error = 1
"}

"vim-unimpaired编辑辅助{
    Plug 'tpope/vim-unimpaired'
"}

"YouCompleteMe代码补全{
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --system-libclang' }
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_confirm_extra_conf = 0 " 不显示开启vim时检查ycm_extra_conf文件的信息
    let g:ycm_add_preview_to_completeopt = 0
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_server_log_level = 'info'
    let g:ycm_min_num_identifier_candidate_chars = 2
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_key_invoke_completion = '<c-z>' " 使用 Ctrl+Z 主动触发语义补全
    let g:ycm_collect_identifiers_from_tag_files = 1 "让YouCompleteMe同时利用原来的ctags
    noremap <c-z> <NOP>
    set completeopt=menu,menuone
    " 修改补全列表配色
    highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
    highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black
    " 对指定源文件，输入两个字母后即触发语义补全
    let g:ycm_semantic_triggers =  {
        \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
        \ 'cs,lua,javascript': ['re!\w{2}'],
        \ }
    let g:ycm_filetype_whitelist = {
        \ "c":1,
        \ "cpp":1,
        \ "go":1,
        \ "python":1,
        \ "lua":1,
        \ "sh":1,
        \ "zsh":1,
        \ }
    let g:ycm_filetype_blacklist = {
        \ 'markdown' : 1,
        \ 'text' : 1,
        \ 'pandoc' : 1,
        \ 'infolog' : 1,
        \ }
"}

"echodoc参数提示{
    Plug 'Shougo/echodoc.vim'
    set noshowmode
"}

"Leader函数列表{
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    let g:Lf_ShortcutF = '<c-p>'
    let g:Lf_ShortcutB = '<m-n>'
    noremap <c-n> :LeaderfMru<cr>
    noremap <m-p> :LeaderfFunction!<cr>
    noremap <m-n> :LeaderfBuffer<cr>
    noremap <m-m> :LeaderfTag<cr>
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.vim/cache')
    let g:Lf_ShowRelativePath = 0
    let g:Lf_HideHelp = 1
    let g:Lf_StlColorscheme = 'powerline'
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
"}

"NERDTree{
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    nmap <C-L> :NERDTreeToggle<CR>
    "打开vim时自动打开NERDTree
    "autocmd vimenter * NERDTree
    "当NERDTree为剩下的唯一窗口时自动关闭
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    "修改树的显示图标
    let g:NERDTreeDirArrowExpandable = '►'
    let g:NERDTreeDirArrowCollapsible = '▼'
    let NERDTreeAutoCenter = 1
    " 显示行号
    let NERDTreeShowLineNumbers = 1
    " 是否显示隐藏文件
    let NERDTreeShowHidden = 1
    " 设置宽度
    let NERDTreeWinSize = 25
    " 在终端启动vim时，共享NERDTree
    let g:nerdtree_tabs_open_on_console_startup = 1
    " 忽略一下文件的显示
    let NERDTreeIgnore=['\.pyc','\~$','\.swp']
    let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "*",
        \ "Staged"    : "+",
        \ "Untracked" : "$",
        \ "Renamed"   : "->",
        \ "Unmerged"  : "=",
        \ "Deleted"   : "X",
        \ "Dirty"     : "x",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '@',
        \ "Unknown"   : "?"
        \ }
"}

"vim-dirvish文件浏览{
"    Plug 'vim-scripts/a.vim'
"    Plug 'justinmk/vim-dirvish'
"}

"vim-indentLine缩进线{
    Plug 'Yggdroot/indentLine'
    "let g:indentLine_color_term = 239
"}

"indent缩进{
    set autoindent             " Indent according to previous line.
    set smartindent            " 智能缩进
    set cindent                " c/c++风格
    set expandtab              " Use spaces instead of tabs.
    set tabstop=4
    set softtabstop=4          " Tab key indents by 4 spaces.
    set shiftwidth=4           " >> indents by 4 spaces.
    set shiftround             " >> indents to next multiple of 'shiftwidth'.
    autocmd BufNewFile,BufRead *.h,*.c setfiletype cpp " h和c文件类型用cpp
    set cinoptions+=l1,g0,t0,W4,:0,j1,(sus,N-s
    Plug 'rhysd/vim-clang-format'
    let g:clang_format#command = 'clang-format' 
    nmap <C-K> :ClangFormat<cr> 
"}

"search{
    set incsearch              " 跟踪搜索
    set hlsearch               " 高亮搜索
    set ignorecase             " 搜索忽略大小写
"}

"括号自动补全{
    Plug 'Raimondi/delimitMate'
"}

"golang {
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"}

call plug#end()
