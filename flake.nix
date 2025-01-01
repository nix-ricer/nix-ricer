{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, ... }: {

    homeManagerModules.default = ./home self;
    nixosModules.default = ./nixos self;

    templates.home-only = {
      path = ./example/home;
      description = "Example flake.nix for building a nix-ricer swappable home-manager desktop module.";
    };
    templates.nixos = {
      path = ./example;
      description = "Example flake.nix for building a nix-ricer swappable nixos desktop module."
    };

  };
}
