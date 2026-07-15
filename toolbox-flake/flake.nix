{
  description = "toolbox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # Define the package output
        packages.default = pkgs.buildEnv {
          name = "toolbox";
          paths = with pkgs; [
            # development
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
            firefox
            deluge
            wireguard-tools
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
        };
      }
    );
}
