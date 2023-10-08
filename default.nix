{
  lib,
  autoPatchelfHook,
  fetchFromGitHub,
  nimPackages,
  pandoc,
  pacman,
}:
nimPackages.buildNimPackage (finalAttrs: {
  pname = "pacclean";
  version = "0.0.1";
  src = ./.;

  meta = {
    description = "Clean up old pacman packages";
    homepage = "https://github.com/eclairevoyant/pacclean";
    #license = lib.licenses.cc-by-nc-sa-40;
    platforms = lib.platforms.linux;
  };

  nativeBuildInputs = [autoPatchelfHook pandoc];
  buildInputs = [pacman];
  hardeningEnable = ["pie"];

  postBuild = ''
    pandoc -s -o ${finalAttrs.pname}.1 doc/pacclean.man1.md
  '';

  postInstall = ''
    install -Dm644 ${finalAttrs.pname}.1 -t "$out/share/man/man1/"
  '';
})
