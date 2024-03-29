require "core"

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- Custom
vim.api.nvim_set_keymap('i', '<C-;>', '<Esc>', { noremap = true, silent = true })

vim.api.nvim_exec("au BufRead,BufNewFile *.asm set ft=nasm", false)
vim.api.nvim_exec("au BufRead,BufNewFile *.typ set ft=typst", false)

vim.g.mkdp_browser = "firefox"
vim.g.wiki_root = "~/Wiki"

vim.g.maplocalleader = " "
