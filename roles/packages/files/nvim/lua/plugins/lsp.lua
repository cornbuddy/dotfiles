vim.diagnostic.config({
  virtual_text = false,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  nmap("<leader>rn", vim.lsp.buf.rename, "[r]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols,
    "[d]ocument [s]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
    "[w]orkspace [s]ymbols")
  nmap("gd", vim.lsp.buf.definition, "[g]o to [d]efinition")
  nmap("gi", vim.lsp.buf.implementation, "[g]o to [i]mplementation")
  nmap("gr", require("telescope.builtin").lsp_references, "[g]o to [r]eferences")
  nmap("K", vim.lsp.buf.hover, "hover documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "signature documentation")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local language_servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "jsonls",
  "lua_ls",
  "pylsp",
  "tofu_ls",
  "gopls",
  "ts_ls",
  "helm_ls",
  "rust_analyzer",
  "templ",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = language_servers,
})

local lsp_setup = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

for _, lang in pairs(language_servers) do
  vim.lsp.config(lang, lsp_setup)
  vim.lsp.enable(lang)
end

vim.filetype.add({
  extension = {
    journal = "hledger",
    hledger = "hledger",
  },
})

local function merge(t1, t2)
  for key, value in pairs(t2) do
    t1[key] = value
  end
  return t1
end

vim.lsp.config("nixd", merge(lsp_setup, {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs = {
        -- For flake.
        -- This expression will be interpreted as "nixpkgs" toplevel
        -- Nixd provides package, lib completion/information from it.
        -- Resource Usage: Entries are lazily evaluated, entire nixpkgs takes 200~300MB for just "names".
        -- Package documentation, versions, are evaluated by-need.
        expr = "import (builtins.getFlake(toString ./.)).inputs.nixpkgs { }",
      },
      formatting = {
        command = { "alejandra" }, -- or nixfmt or nixpkgs-fmt
      },
      options = {
        nixos = {
          expr =
          "let flake = builtins.getFlake(toString ./.); in flake.nixosConfigurations.nz.options",
        },
      },
    },
  },
}))
vim.lsp.enable("nixd")

vim.lsp.config("hledger_lsp", merge(lsp_setup, {
  cmd = { "hledger-lsp" },
  filetypes = { "hledger", "journal" },
  root_markers = { ".git", "*.journal" },
  single_file_support = true,
}))

vim.lsp.enable("hledger_lsp")
