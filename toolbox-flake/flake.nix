{
  description = "toolbox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.default = pkgs.buildEnv {
          name = "toolbox";
          ignoreCollisions = true;
          paths = with pkgs; [
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
            nixd
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
      };
}
