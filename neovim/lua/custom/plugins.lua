local plugins = {
  {
    "lervag/wiki.vim",
    lazy = false
  },
  {
    "wakatime/vim-wakatime",
    lazy = false
  },
  {
    "lukas-reineke/lsp-format.nvim",
    lazy = false
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      table.insert(M.sources, {
        {
          name = "crates"
        },
        {
          name = "spell",
          options = {
            keep_all_entries = false,
            enable_in_context = function()
              return true
            end
          }
        }
      })
      return M
    end
  },
  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    opts = function()
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
          null_ls.builtins.formatting.csharpier,
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
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      local fmt = require("lsp-format")
      fmt.setup {}

      function on_attach(client, buffnr)
        fmt.on_attach(client, buffnr)
      end

      lspconfig.ltex.setup {}

      lspconfig.marksman.setup {}

      lspconfig.texlab.setup {}

      lspconfig.lemminx.setup {
        on_attach = on_attach
      }

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
                  version = 'LuaJIT'
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME
                  }
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
        cmd = { "omnisharp" }
      }

      lspconfig.hls.setup {
        on_attach = on_attach
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ltex-ls",
        "marksman",
        "texlab",
        "lemminx",
        "bash-language-server",
        "asm-lsp",
        "asmfmt",
        "clangd",
        "clang-format",
        "rust-analyzer",
        "lua-language-server",
        "omnisharp",
        "csharpier",
        "haskell-language-server"
      }
    }
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    "lervag/vimtex",
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
  },
  {
    "p00f/clangd_extensions.nvim",
    lazy = false,
  },
  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "saecki/crates.nvim",
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
    end
  },
}
return plugins
