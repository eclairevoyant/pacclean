version     = "0.0.1"
author      = "éclairevoyant"
description = "Clean up old pacman packages"
license     = "CC-by-nc-sa"
srcDir      = "src"
bin         = @["pacclean"]

task release, "Release build":
  exec "nimble build -d:release --opt:speed"
  exec "pandoc -s -o pacclean.1 doc/pacclean.man1.md"
