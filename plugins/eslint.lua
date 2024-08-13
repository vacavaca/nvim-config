local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

-- Eslint
nvim_lsp.eslint.setup {}
