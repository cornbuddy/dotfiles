require('nvim-treesitter.config').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "bash",
    "comment",
    "dockerfile",
    "hcl",
    "groovy",
    "python",
    "rust",
    "toml",
    "yaml",
    "lua",
    "go",
    "gomod",
    "gosum",
    "templ",
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
