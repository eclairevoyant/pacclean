{
  lib,
  autoPatchelfHook,
  fetchFromGitHub,
  nimPackages,
  pandoc,
  pacman,
}:
nimPackages.buildNimPackage (finalAttrs: rec {
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
  buildPhase = ''
    runHook preBuild
    nim_builder --phase:build
    pandoc -s -o ${pname}.1 doc/pacclean.man1.md
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    nim_builder --phase:install
    install -Dm644 ${pname}.1 -t "$out/share/man/man1/"
    runHook postInstall
  '';
})
