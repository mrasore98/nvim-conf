{
  description = "Custom neovim configuration via NVF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }@inputs: {

    packages.x86_64-linux.nvim = (nvf.lib.neovimConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./nvim.nix ];
    }).neovim;

    packages.x86_64-linux.default = self.packages.x86_64-linux.nvim;

  };
}
