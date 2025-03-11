local status, nvim_lsp = pcall(require, "lspconfig")
local util = require 'lspconfig.util'
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider and vim.lsp.buf.formatting_seq_sync ~= nil then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
  end
end


nvim_lsp.denols.setup {
  on_attach = on_attach,
  root_dir = function (path) 
    local git = util.root_pattern('.git')(path)
    local deno = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")(path)
    if git ~= nil and deno ~= nil then
        return git
    end

    return nil
  end
}

-- TypeScript
nvim_lsp.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = '/usr/local/lib/node_modules/@vue/typescript-plugin',
        languages = { 'vue' },
      },
    },
  },
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "vue", "javascript", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
  single_file_support = false,
  root_dir = function(path)
        local git = util.root_pattern('.git')(path)
        local pkg = util.root_pattern('package.json')(path)
        if git ~= nil and pkg ~= nil then
            return git
        end

        if git ~= nil then return git else return pkg end
  end
}

nvim_lsp.volar.setup {
  root_dir = function(path)
        local git = util.root_pattern('.git')(path)
        local pkg = util.root_pattern('package.json')(path)
        if git ~= nil and pkg ~= nil then
            return git
        end

        if git ~= nil then return git else return pkg end
  end
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    --  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
