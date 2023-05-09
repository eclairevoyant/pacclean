#compdef pacclean

typeset -A opt_args
typeset -a _pacclean_opts
_pacclean_opts=(
	'-h[help]'
	'--file-size[human-readable total file size]'
	'--file-size-bytes[total file size in bytes]'
	'-c[number of versions to unmark]'
	'-r[mark packages/files not in repo db]'
)
