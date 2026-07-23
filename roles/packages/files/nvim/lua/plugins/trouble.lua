--- very similar modules, so I'll just put it there
require('diagflow').setup({
  scope = 'line',
  show_borders = true,
})

require("trouble").setup({})

local nmap = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

nmap('<F4>', ":Trouble diagnostics toggle<CR>", "diagnostic")
