{
  description = "Clean up old pacman packages";

  inputs.flakeNimbleLib.url = "github:riinr/nim-flakes-lib";
  inputs.nixpkgs.url        = "github:nixos/nixpkgs";

  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";

  outputs = inputs:
    inputs.flakeNimbleLib.lib.mkRefOutput {
      nixpkgs = inputs.nixpkgs;
      self    = inputs.self;
      src     = ./.; # source could be an input also
      meta.ref     = "main";
      meta.version = "0.0.1";
      meta.name    = "pacclean";
      meta.desc    = "Clean up old pacman packages";
    }
}
