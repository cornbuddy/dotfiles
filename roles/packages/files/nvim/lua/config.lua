-- wanted by auto-session
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.mouse = ""
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 10
vim.opt.swapfile = false

vim.opt.listchars = {
  tab = "▷⋅",
  trail = "⋅",
}
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.colorcolumn = "80"

-- remove trailing characters on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- autoformat buffer on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})
