local on_attach = function(client, server)
  if server == "efm" then
    client.server_capabilities.document_formatting = true
  else
    client.server_capabilities.document_formatting = false
  end

  print("'" .. client.name .. "' server attached")
end

require "lspconfig".angularls.setup {
  on_attach = on_attach
}
