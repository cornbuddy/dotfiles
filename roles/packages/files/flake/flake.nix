{
  description = "toolbox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self, # auto-provided; kept in the arg set so `nix profile add` works
    nixpkgs,
  }: let
    # each supported system gets its own package set and toolbox
    systems = ["x86_64-linux" "aarch64-linux"];

    # apply f once per system, with that system's own pkgs
    forAllSystems = f:
      builtins.listToAttrs (map (system: {
          name = system;
          value = f (nixpkgs.legacyPackages.${system});
        })
        systems);

    mkToolbox = pkgs: name: paths:
      pkgs.buildEnv {
        inherit name paths;
        ignoreCollisions = false;
      };

    toolbox = pkgs: let
      lib = pkgs.lib;
      base = import ./base/base.nix {inherit pkgs;};

      # every *.nix in ./hosts is a machine; the basename is its hostname
      machineFiles =
        builtins.filter
        (lib.hasSuffix ".nix")
        (builtins.attrNames (builtins.readDir ./hosts));

      hostsets = builtins.listToAttrs (map (file: {
          name = lib.removeSuffix ".nix" file;
          value = import ./hosts/${file} {inherit pkgs;};
        })
        machineFiles);

      # one output per machine hostname; the host file must exist or
      # `nix profile add .#<hostname>` fails (intentionally)
      hostOutputs = builtins.listToAttrs (map (name: {
        inherit name;
        value = mkToolbox pkgs "toolbox-${name}" (base ++ hostsets.${name});
      }) (builtins.attrNames hostsets));
    in
      hostOutputs
      // {
        # default = base toolbox only; a machine is picked by hostname
        default = mkToolbox pkgs "toolbox-default" base;
      };
  in {
    packages = forAllSystems toolbox;
  };
}
