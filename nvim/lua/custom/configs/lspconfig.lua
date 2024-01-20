local lspconfig = require("lspconfig")

local fmt = require("lsp-format")
fmt.setup {}

local function on_attach(client, buffnr)
  fmt.on_attach(client, buffnr)
end

lspconfig.marksman.setup {}

lspconfig.bashls.setup {
  on_attach = on_attach
}

lspconfig.asm_lsp.setup {
  filetypes = { "nasm" },
  on_attach = on_attach
}

lspconfig.clangd.setup {
  filetypes = { "c", "cpp" },
  on_attach = on_attach,
}

lspconfig.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end,
  on_attach = on_attach
}

lspconfig.omnisharp.setup {
  cmd = { "omnisharp" },
  organize_imports_on_format = true,
  on_attach = on_attach
}

lspconfig.lemminx.setup {
  on_attach = on_attach
}
