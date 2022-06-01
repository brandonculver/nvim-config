 local lspconfig = require('lspconfig')
 vim.g.coq_settings = { auto_start = 'shut-up' }

 --Enable some language servers with the additional completion capabilities offered by nvim-cmp
 local servers = { 'html', 'cssls', 'tsserver' }
 for _, lsp in ipairs(servers) do
   lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
     --on_attach = my_custom_on_attach,
   }))
  end
