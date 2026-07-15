{
  description = "toolbox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # Define the package output
        packages.${system}.default = pkgs.buildEnv {
          name = "toolbox";
          paths = with pkgs; [
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
