% PACCLEAN(1)

# NAME

pacclean - a utility to list old pacman packages in a given directory

# SYNOPSIS

`pacclean [ -h | ([--file-size | --file-size-bytes] [-c COUNT_TO_KEEP | -r REPO_FILE] [DIRECTORY]) ]`

# OPTIONS
`-h, --help`
: Display help message

`--file-size`
: Display total file size (human-readable) of old files

`--file-size-bytes`
: Display total file size (in bytes) of old files

`-c, --count COUNT_TO_KEEP`
: Exclude COUNT_TO_KEEP recent versions of each package in DIRECTORY. If option is not specified, 1 recent version will be excluded.

`-r, --repo-unused REPO_FILE`
: Include all versions of packages that are not part of REPO_FILE (relative to DIRECTORY). This ignores `-c` for such packages.

`--sort`
: Sort output

`-v, --verbose`
: Print excluded files to stderr

# BUGS

https://github.com/eclairevoyant/pacclean/issues
