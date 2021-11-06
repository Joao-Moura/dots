local cmd = vim.cmd
local opt = vim.opt
local g = vim.g

opt.syntax = 'enable'
opt.encoding = 'utf-8'
-- opt.matchpairs = { '(:)', '[:]', '{:}', '<:>', '<!--:-->' }

opt.autoindent = true
opt.smartindent = true

opt.tabstop = 8
opt.shiftwidth = 4
opt.expandtab = true

opt.wildmenu = true
opt.hlsearch = true

opt.number = true
opt.rnu = true
opt.wrap = true
opt.lazyredraw = true
opt.mouse = 'a'
opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.termguicolors = true
