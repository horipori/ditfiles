if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf-8

    " 利用可能な場合は true color を有効化する
  if !has('gui_running')
        \ && exists('&termguicolors')
        \ && $COLORTERM ==# 'truecolor'
    " tmux 等でも強制的に termguicolors を有効化するための設定 (Neovim では不要)
    " https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
    if !has('nvim')
      let &t_8f = "\e[38;2;%lu;%lu;%lum"
      let &t_8b = "\e[48;2;%lu;%lu;%lum"
    endif
    set termguicolors       " use truecolor in term
  endif
endif

" スペースキーをLeaderに
noremap <Leader>      <Nop>
noremap <LocalLeader> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = '\'

let g:python3_host_prog = expand('$HOME') . '/usr/local/bin/python3'

"set rtp+=/usr/local/share/nvim/runtime/

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/vim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

let g:python_host_prog = '/usr/local/opt/python/libexec/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" 任意ディレクトリに存在する vimrc による悪意を持ったコマンド実行を防ぐ
" ~/.vimrc や ~/.config/nvim/init.vim の一番最後には必ず書くのがお薦め
set secure

" teminal modeからnormal modeに
tnoremap <silent> <ESC> <C-\><C-n>

nmap <ESC><ESC> :nohl<CR><ESC>

" Camelcase の単語間移動を変更
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

map <C-n> <plug>NERDTreeTabsToggle<CR>

filetype plugin indent on

augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

set autoindent        " 自動でインデント
set expandtab         " タブの代わりに空白を挿入
set tabstop=2         " タブのインデント幅
set shiftwidth=2      " 自動インデントの幅を指定
set incsearch         " [検索]入力の度に検索する
set nowrapscan        " [検索]先頭にループしない
set hlsearch          " [検索]文字をハイライトする
set noswapfile        " スワップファイルを作らない
"set noundofile        " アンドゥファイルを作らない
set undofile          " アンドゥファイルを作る
set undodir=~/.cache/vim/undo
set number            " 行番号を表示
"set ambiwidth=double  " vimに全角を解釈させる "←有効にするとterminalモードの時に描画がおかしくなる
set mouse=a
set virtualedit=block " 矩形選択で文字がなくても右へ進める

" システムのクリップボードを利用する
" " OS 種により利用するべき値が違うため分岐させている
" " - unnamed     : 'selection' in X11; clipboard in Mac OS X and Windows
" " - unnamedplus : 'clipboard' in X11, Mac OS X, and Windows (but yank)
"if has('win32') || has('win64') || has('mac')
"  set clipboard=unnamed
"else
"  set clipboard=unnamed,unnamedplus
"endif

colorscheme molokai
set t_Co=256
highlight Normal ctermbg=none

syntax on

" 対応するかっこが見辛いので色を変える
highlight MatchParen ctermfg=208 ctermbg=233 cterm=bold guifg=#FD971F guibg=#000000 gui=bold
