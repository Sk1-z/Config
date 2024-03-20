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
          null_ls.builtins.formatting.mdformat,
          null_ls.builtins.formatting.typstfmt,
          null_ls.builtins.formatting.latexindent,
          asmfmt,
          null_ls.builtins.formatting.csharpier,
          null_ls.builtins.formatting.black
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

      lspconfig.ltex.setup {
        filetypes = { "markdown", "typst" }
      }

      lspconfig.marksman.setup {}

      lspconfig.typst_lsp.setup {
        settings = {
          exportPdf = "onType"
        }
      }

      lspconfig.texlab.setup {}

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
        on_attach = on_attach
      }

      lspconfig.omnisharp.setup {
        cmd = { "omnisharp" }
      }

      lspconfig.hls.setup {
        on_attach = on_attach
      }

      lspconfig.pyright.setup {}
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ltex-ls",
        "marksman",
        "mdformat",
        "typst-lsp",
        "typstfmt",
        "texlab",
        "bash-language-server",
        "asm-lsp",
        "asmfmt",
        "clangd",
        "clang-format",
        "rust-analyzer",
        "omnisharp",
        "csharpier",
        "haskell-language-server",
        "pyright",
        "black"
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
    "kaarmu/typst.vim",
    lazy = false
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
