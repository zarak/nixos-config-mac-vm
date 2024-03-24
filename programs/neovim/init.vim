" Don't try to be vi compatible
set nocompatible
set clipboard=unnamed

" Helps force plugins to load correctly when it is turned back on below
filetype off

" TODO: Load plugins here (pathogen or vundle)
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
"Plug 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'

" Plug 'Valloric/YouCompleteMe'
" let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']

Plug 'ervandew/supertab'
"let g:SuperTabDefaultCompletionType    = '<C-n>'
"let g:SuperTabDefaultCompletionType    = 'context'
let g:SuperTabDefaultCompletionType = "<C-x><C-o>"
let g:SuperTabCrMapping                = 0

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "extra_math_snippets"]

" React code snippets
Plug 'mlaursen/vim-react-snippets'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

"Plug 'ctrlpvim/ctrlp.vim'

"Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

Plug 'jiangmiao/auto-pairs'

" Plug 'scrooloose/nerdtree'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'benmills/vimux'

Plug 'scrooloose/nerdcommenter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'lervag/vimtex'

Plug 'KeitaNakamura/tex-conceal.vim'

Plug 'jez/vim-better-sml'

Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
" Plug 'mxw/vim-jsx'

Plug 'leafgarland/typescript-vim'

Plug 'elmcast/elm-vim'

"Plug 'w0rp/ale'

"if has('nvim')
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
  "Plug 'Shougo/deoplete.nvim'
  "Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
"endif
"let g:deoplete#enable_at_startup = 1

" For C# and haskell
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'https://github.com/tpope/vim-rhubarb.git'

" Search in files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Plug 'OmniSharp/omnisharp-vim'

"Plug 'OrangeT/vim-csharp'

"Plug 'maslaral/the-creator.vim'
"Plug 'alexkh/vimcolors'
Plug 'cjgajard/patagonia-vim'

Plug 'srcery-colors/srcery-vim'

" Syntax highlighting
"
" Disable html for sane indenting in script tags in html files
" Remove conflict with vimtex (disable latex)
let g:polyglot_disabled = ['latex', 'html']
 
Plug 'sheerun/vim-polyglot'

" For Typescript
"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }

" Plug 'simnalamburt/vim-mundo'
"
" Use this vim-mundo fork that has a fix for this error: 
" https://github.com/simnalamburt/vim-mundo/issues/123
Plug 'TamaMcGlinn/vim-mundo'

Plug 'alvan/vim-closetag'

" post install (yarn install | npm install)
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Plug 'ionide/Ionide-vim', {
      " \ 'do':  'make fsautocomplete',
      " \}

Plug 'neovimhaskell/haskell-vim'
Plug 'drewtempelmeyer/palenight.vim'

" Terminal splitting with :Term
Plug 'vimlab/split-term.vim'

Plug 'leanprover/lean.vim'

Plug 'flazz/vim-colorschemes'

Plug 'purescript-contrib/purescript-vim' 
Plug 'frigoeu/psc-ide-vim'


Plug 'edwinb/idris2-vim'

Plug 'chrisbra/NrrwRgn'

Plug 'mattn/emmet-vim'

Plug 'wellle/targets.vim'

" Plug 'sbdchd/neoformat'

Plug 'chaoren/vim-wordmotion'

Plug 'ggandor/lightspeed.nvim'

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'cocopon/iceberg.vim'

Plug 'sainnhe/gruvbox-material'

Plug 'tomasiser/vim-code-dark'

" Plug 'github/copilot.vim'

Plug 'hylang/vim-hy'

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


" Initialize plugin system
call plug#end()

" All of your Plugs must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
" 
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just
" :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plug stuff after this line



" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
let mapleader = ","

" Security
set modelines=0

" Show line numbers
set number

" Show file stats
set ruler

" Blink cursor on error instead of beeping (grr)
set visualbell

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Allow hidden buffers
set hidden

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>

" Textmate holdouts

" Formatting
map <leader>q gqip

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
"set t_Co=256
set background=dark
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized
"colorscheme lettuce


" Default
" colorscheme palenight

colorscheme codedark
" colorscheme gruvbox-material
" colorscheme iceberg
" colorscheme srcery
" colorscheme the-creator
" colorscheme sv
" colorscheme patagonia

" vimux run command keymap
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>rb :call VimuxRunCommand("clear; gcc " . bufname("%") . " && ./a.out")<CR>

" Add to runtimepath directory for plugin from VimL book
set runtimepath+=/Users/zarak/Documents/VimL

" Increase command history limit
set history=200

" Set relative numbering
set relativenumber

" fzf fuzzyfinder
set rtp+=/usr/local/opt/fzf

" Disable callback feature for vimtex
"let g:vimtex_compiler_latexmk = {'callback' : 0}
"
" https://castel.dev/post/lecture-notes-1/
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0

" tex-conceal
set conceallevel=1
let g:tex_conceal='abdmg'
let g:hy_enable_conceal = 1
hi Conceal ctermbg=none


" Change windows in terminal mode of vim-better-sml
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" ----- Keybindings -----
nnoremap <leader>t :SMLTypeQuery<CR>

" open the REPL terminal buffer
nnoremap <leader>is :SMLReplStart<CR>
" close the REPL (mnemonic: k -> kill)
nnoremap <leader>ik :SMLReplStop<CR>

" directory for notational fzf to search
let g:nv_search_paths = ['~/notes', './notes.md']

" Set shell to zsh
"set shell=/bin/zsh

" Save marks after file exit
set viminfo='100,f1

"""""""""""""""""""""""""""""""""
" OMNI SHARP OPTIONS START
"
"let g:ale_linters = {
"\ 'cs': ['OmniSharp']
"\}

" Use the stdio version of OmniSharp
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
"let g:ale_linters = { 'cs': ['OmniSharp'] }
"
" Tell ALE to use these linters for haskell
let g:ale_linters = {'haskell': ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc']}

" Update semantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

let g:OmniSharp_selector_ui = 'fzf'

" Enable snippet completion
 "let g:OmniSharp_want_snippet=1
"
" OMNI SHARP OPTIONS END
"""""""""""""""""""""""""""""""""

" Haskell Coc Options START
"""""""""""""""""""""""""""""""""""""

" let g:coc_start_at_startup=0


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Run the Code Lens action on the current line.
xmap <leader>al  <Plug>(coc-codelens-action)
nmap <leader>al  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Haskell Coc Options END
"""""""""""""""""""""""""""""""""""""



" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

" Helpers for resolving merge conflicts
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Fsharp
"let g:LanguageClient_serverCommands = {
    "\ 'fsharp': ['dotnet', '/Users/name/code/fsharp-language-server/src/FSharpLanguageServer/bin/Release/netcoreapp2.0/target/FSharpLanguageServer.dll']
    "\ }


" Config for split-term plugin
let g:disable_key_mappings = 1
set splitbelow

" Undo tree
nnoremap <leader>m :MundoToggle<CR>
set undofile

" fzf mappings
nnoremap <C-g> :Rg<Cr>
nnoremap <C-p> :Files<Cr>

" Spelling
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Narrow region HSX
let g:nrrw_custom_options={} 
let g:nrrw_custom_options['filetype'] = 'html'
let g:nrrw_rgn_resize_window = 'relative'

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Formatter for haskell
set formatprg=stylish-haskell

" Use vim surround keybindings for vim-sandwich
runtime macros/sandwich/keymap/surround.vim

" NvimTree config
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

lua << EOF
require'nvim-tree'.setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        item = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = "",
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  filesystem_watchers = {
    enable = false,
    interval = 100,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = "gio trash",
    require_confirm = true,
  },
  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
}
EOF

" NvimTree Config End
""""""""""""""""""""""""

" Launch cabal repl
nnoremap <leader>cr :15Term cabal repl<CR>
nnoremap <C-w>e :resize 15<CR>
