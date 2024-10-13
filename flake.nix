{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
   nixpkgs-master.url = "github:NixOS/nixpkgs/master";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-master,  ... }: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = { 
	pkgs-master = import nixpkgs-master{
		inherit system;
		config.allowUnfree = true;
};
 };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
      ];
    };
  };
}
