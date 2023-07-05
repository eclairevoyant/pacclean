{ lib, autoPatchelfHook, fetchFromGitHub, nimPackages, pacman }:

nimPackages.buildNimPackage(finalAttrs: {
  pname = "pacclean";
  version = "0.0.1";
  src = ./.;
  meta = {
    description = "Clean up old pacman packages";
    homepage = "https://github.com/eclairevoyant/pacclean";
    license = lib.licenses.cc-by-nc-sa-40;
    platforms = lib.platforms.linux;
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ pacman ];
})
