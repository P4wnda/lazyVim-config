vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "clangd" then
      client.server_capabilities.signatureHelpProvider = false
      vim.schedule(function()
        vim.lsp.handlers["textDocument/signatureHelp"] = function() end
      end)
    end
  end,
})
