{pkgs, ...}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "cornbuddy";
  home.homeDirectory = "/home/cornbuddy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # wm
    waybar
    fuzzel
    swaylock
    mako
    swayidle
    lm_sensors
    networkmanagerapplet
    swaynotificationcenter
    # development
    babelfish
    devenv
    nixd
    alejandra
    bun
    luaPackages.tree-sitter-cli
    neovim
    tree-sitter
    cargo
    clippy
    rustc
    go
    delve
    tflint
    ruby
    rustfmt
    gcc
    gnumake
    nodejs_24
    jdk25
    python314
    opentofu
    terraform-docs
    terragrunt
    awscli2
    ansible
    git
    tmux
    gitmux
    pre-commit
    action-validator
    xsel
    wl-clipboard
    # language servers
    rust-analyzer
    ansible-language-server
    dockerfile-language-server
    docker-compose-language-service
    lua-language-server
    tofu-ls
    gopls
    helm-ls
    ccls
    # containers
    minikube
    docker
    docker-buildx
    docker-compose
    kubernetes-helm
    kustomize
    fluxcd
    podman
    # tools
    net-tools
    wireguard-tools
    curl
    dig
    jq
    ripgrep
    openssh
    fish
    zip
    unzip
    htop
    tree
    file
    hledger
    hledger-ui
    hledger-web
    hledger-fmt
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/cornbuddy/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
