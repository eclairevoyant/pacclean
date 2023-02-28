# `pacclean`

Identify duplicate Arch Linux packages in a given directory. Similar to `paccache`, but intentionally ignores file timestamps and does not perform any deletion (this program's output can be piped to `rm`).

## License

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.


## TODO
- [x] print out associated .sig files
- [ ] print out orphaned (package or version doesn't exist) .sig files
- [ ] handle -debug packages?
- [x] option to specify how many package versions to ignore
- [x] option to specify target directory
- [ ] print out ignored packages in verbose mode
- [x] handle arbitrary, unspecified package extensions
- [ ] rename repo to be more descriptive
- [ ] option to handle orphaned packages (not part of repo)
- [ ] sort final output
- [x] option to output stats
- [x] add pkgbuild and nimble file
- [ ] auto-generate
    - [ ] docs
    - [ ] help message
    - [ ] shell completions
