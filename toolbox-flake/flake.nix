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
          pathsToLink = [ "/bin" "/share" ];
          paths = with pkgs; [
            # wm
            waybar
            fuzzel
            swaylock
            mako
            swayidle
            # development
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
        };
      }
    );
}
