version = "0.0.1"
author = "éclairevoyant"
description = "Clean up old pacman packages"
license = "CC-by-nc-sa"

task debug, "Debug build":
  exec "nim c -o:bin/pacclean pacclean/pacclean.nim"

task release, "Release build":
  exec "nim c -o:bin/pacclean -d:release --opt:speed pacclean/pacclean.nim"
