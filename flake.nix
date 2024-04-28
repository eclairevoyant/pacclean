{
  description = "Clean up old pacman packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      overlays.default = f: _: { pacclean = f.callPackage ./. { }; };
      packages.${system}.default = pkgs.callPackage ./. { };
    };
}
