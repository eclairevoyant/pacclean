# `vercmp.nim`

Identify duplicate Arch Linux packages in a given directory. Similar to `paccache`, but intentionally ignores file timestamps and does not perform any deletion (this program's output can be piped to `rm`).


## TODO
- [ ] handle .sig files
- [ ] option to specify how many package versions to ignore
- [ ] option to specify target directory
- [ ] print out ignored packages in verbose mode (to `stderr`)
- [ ] handle arbitrary, unspecified package extensions
- [ ] rename repo to be more descriptive
- [ ] option to handle packages not part of repo
