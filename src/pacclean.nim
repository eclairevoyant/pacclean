import std/[algorithm,os,sequtils,strutils,sugar,tables]

func alpm_pkg_vercmp(a: cstring; b: cstring): cint {.dynlib: "libalpm.so", importc.}
func verCmp(a: string, b: string): int = alpm_pkg_vercmp(a, b)

func pkginfo(s: string): (string, string, string) =
  # don't split more than 3 times, because package names can have '-'
  var splits = s.rsplit('-', maxsplit=3)
  if (splits.len > 3):
    return (splits[0], splits[1], splits[2])
  return ("", "", "")

let 
  fileList = collect(newSeq):
    # TODO pass dir as option
    # TODO catch OSError
    for kind, path in walkDir(".", true, true):
      if kind == pcFile: path
  # TODO check basename, not path
  packageList = fileList.filter(p => p.contains(".pkg.tar") and not p.endsWith(".sig"))

var
  packageMap = initTable[string, seq[(string, string)]]()

for p in packageList:
  var info = pkginfo(p)
  var pkgname = info[0]
  var ver = info[1] & "-" & info[2]
  if not (pkgname in packageMap):
    packageMap[pkgname] = @[]
  packageMap[pkgname].add((ver, p))

packageMap.del("")

var toDelete: seq[string]

# TODO filter "" here
for p in packageMap.keys:
  sort(packageMap[p], (a, b) => verCmp(a[0], b[0]), SortOrder.Descending)
  # exclude latest package from deletion
  # TODO opt to change count of recent packages to keep
  packageMap[p].delete(0..0)
  toDelete = toDelete.concat(packageMap[p].map(x => x[1]))

for p in toDelete:
  echo p
  if fileList.contains(p & ".sig"):
    echo p & ".sig"
