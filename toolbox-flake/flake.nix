{
  description = "Cross-platform toolbox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Define your common package list
      commonPackages = pkgs: with pkgs; [
        # development
        neovim
        tree-sitter
        moon
        buck2
        bazel_7
        cargo
        clippy
        rustc
        go
        delve
        tflint
        bundler
        ruby
        rustfmt
        gcc
        gnumake
        nodejs_24
        jdk23
        python313
        python313Packages.pip
        terraform
        terraform-docs
        terragrunt
        awscli2
        ansible
        git
        tmux
        gitmux
        pre-commit
        packer
        action-validator
        # language servers
        rust-analyzer
        ansible-language-server
        nodePackages.bash-language-server
        dockerfile-language-server-nodejs
        docker-compose-language-service
        lua-language-server
        python312Packages.python-lsp-server
        terraform-ls
        gopls
        helm-ls
        ccls
        # containers
        minikube
        docker
        docker-buildx
        docker-compose
        kubectl
        kubernetes-helm
        kustomize
        fluxcd
        # window manager
        hyprland
        hyprlock
        hypridle
        wlogout
        wl-clipboard
        waybar
        tofi
        brightnessctl
        # tools
        google-chrome
        firefox
        deluge
        wireguard-tools
        sudo-rs
        acpi
        pavucontrol
        curl
        dig
        jq
        ripgrep
        openssh
        fish
        alacritty
        zip
        unzip
        htop
        tree
        file
      ];

      # Helper to build a unified profile
      mkProfile = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          # Filter out packages that don't exist on this platform
          available = builtins.filter (p: p.meta.available or true) (commonPackages pkgs);
        in
        pkgs.symlinkJoin {
          name = "toolbox";
          paths = available;
        };
    in
    {
      # Expose a package for each system
      packages = {
        x86_64-linux   = mkProfile "x86_64-linux";
        aarch64-linux  = mkProfile "aarch64-linux";
        x86_64-darwin  = mkProfile "x86_64-darwin";
        aarch64-darwin = mkProfile "aarch64-darwin";
      };

      # Optional: default package for convenience
      defaultPackage = self.packages.${builtins.currentSystem} or null;
    };
}
