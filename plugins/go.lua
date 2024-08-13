local status, nvim_lsp = pcall(require, "lspconfig")
local util = require 'lspconfig.util'
if (not status) then return end

require'lspconfig'.gopls.setup{}

