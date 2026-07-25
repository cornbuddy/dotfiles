{
  description = "home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    homeConfigurations.cornbuddy = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {inherit inputs;};
      modules = [./home.nix];
    };
  };
}
