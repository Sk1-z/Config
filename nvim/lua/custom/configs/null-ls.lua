local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local asmfmt = {
  method = null_ls.methods.FORMATTING,
  filetypes = { "nasm" },
  generator = null_ls.formatter({
    command = "asmfmt",
    to_stdin = true,
  }),
}

local opts = {
  sources = {
    asmfmt,
    null_ls.builtins.diagnostics.misspell.with({
      filetypes = { "toml", "yaml", "markdown" },
    }),
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_clear_autocmds({
      group = augroup,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end,
}

return opts
