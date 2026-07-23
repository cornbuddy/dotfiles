require("nvim-tree").setup({})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    require("nvim-tree.api").tree.open()
  end
})

vim.keymap.set('n', '<leader>t', ':NvimTreeFindFileToggle<CR>')

require 'nvim-web-devicons'.setup {
  -- globally enable different highlight colors per icon (default to true)
  -- if set to false all icons will have the default icon's color
  color_icons = true,
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
  -- globally enable "strict" selection of icons - icon will be looked up in
  -- different tables, first by filename, and if not found by extension; this
  -- prevents cases when file doesn't have any extension but still gets some icon
  -- because its name happened to match some extension (default to false)
  strict = true,
}
