{pkgs, ...}:
with pkgs; [
  # wm / desktop
  waybar
  fuzzel
  lm_sensors
  networkmanagerapplet
  swaynotificationcenter
  wl-clipboard
  brightnessctl
  tomat
  # languages
  rustc
  cargo
  clippy
  rustfmt
  rust-analyzer
  # development
  gitmux
  pre-commit
  neovim
  git
  zellij
  ripgrep
  tree-sitter
  luaPackages.tree-sitter-cli
  gnumake
  go
  gopls
  golangci-lint
  python314
  ruby
  devenv
  nixd
  alejandra
  action-validator
  # language servers
  ansible-language-server
  dockerfile-language-server
  docker-compose-language-service
  lua-language-server
  helm-ls
  ccls
  just-lsp
  # infra / cloud
  ansible
  opentofu
  tflint
  terraform-docs
  terragrunt
  awscli2
  # containers
  kubectl
  kubernetes-helm
  kustomize
  fluxcd
  # tools
  net-tools
  wireguard-tools
  xsel
  jq
  curl
  dig
  openssh
  zip
  unzip
  htop
  tree
  file
]
