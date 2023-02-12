# `pacclean`

Identify duplicate Arch Linux packages in a given directory. Similar to `paccache`, but intentionally ignores file timestamps and does not perform any deletion (this program's output can be piped to `rm`).

## License

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.


## TODO
- [ ] handle .sig files
- [ ] option to specify how many package versions to ignore
- [ ] option to specify target directory
- [ ] print out ignored packages in verbose mode (to `stderr`?)
- [ ] handle arbitrary, unspecified package extensions
- [ ] rename repo to be more descriptive
- [ ] option to handle packages not part of repo
- [ ] sort final output by using orderedtable
- [ ] option to output stats? which may necessitate a deletion option
- [x] add pkgbuild and nimble file
