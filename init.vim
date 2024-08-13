call plug#begin(stdpath('data'))
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'morhetz/gruvbox'
Plug 'rebelot/kanagawa.nvim'
Plug 'slugbyte/lackluster.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
call plug#end()

let g:ctrlp_custom_ignore = '\v[\/]((\.git)|node_modules|build|dist)$'

set shiftwidth=4 smarttab expandtab tabstop=4

:luafile ~/.config/nvim/plugins/web-devicons.lua
:luafile ~/.config/nvim/plugins/typescript.lua
:luafile ~/.config/nvim/plugins/treesitter.lua
:luafile ~/.config/nvim/plugins/nvim-tree.lua
:luafile ~/.config/nvim/plugins/keys.lua
:luafile ~/.config/nvim/plugins/eslint.lua
:luafile ~/.config/nvim/plugins/cmp.lua
:luafile ~/.config/nvim/plugins/lua.lua
:luafile ~/.config/nvim/plugins/go.lua

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"colorscheme gruvbox
:luafile ~/.config/nvim/plugins/kanagawa.lua
"colorscheme lackluster-hack

:noremap Y yy
cnoreabbrev W w
cnoreabbrev U <C-r>

set exrc

:nnoremap <Leader>pp :lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
command FindSymbol :lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>

let g:ctrlp_working_path_mode=''
let g:ctrlp_show_hidden=1

set number
