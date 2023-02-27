import std/[algorithm,math,os,sequtils,strformat,strutils,sugar,tables]

func alpm_pkg_vercmp(a: cstring; b: cstring): cint {.dynlib: "libalpm.so", importc.}
func verCmp(a: string, b: string): int = alpm_pkg_vercmp(a, b)

func `/`(x, y: BiggestInt): BiggestFloat = toBiggestFloat(x) / toBiggestFloat(y)

func pkginfo(s: string): (string, string, string) =
  # don't split more than 3 times, because package names can have '-'
  let splits = s.rsplit('-', maxsplit=3)
  if (splits.len > 3):
    return (splits[0], splits[1], splits[2])
  return ("", "", "")

func humanReadable(i: BiggestInt): (BiggestFloat, string) =
  let ifloat = toBiggestFloat(i)
  if unlikely(i >= (2 ^ 50)):
    return (i / (2 ^ 50), "P")
  if unlikely(i >= (2 ^ 40)):
    return (i / (2 ^ 40), "T")
  if (i >= (2 ^ 30)):
    return (i / (2 ^ 30), "G")
  if (i >= (2 ^ 20)):
    return (i / (2 ^ 20), "M")
  if (i >= (2 ^ 10)):
    return (i / (2 ^ 10), "K")
  return (toBiggestFloat(i), "")

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
  let
    info = pkginfo(p)
    pkgname = info[0]
    ver = info[1] & "-" & info[2]
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

var totalSize: BiggestInt
for p in toDelete:
  echo p
  totalSize += getFileSize(p)
  if fileList.contains(p & ".sig"):
    echo p & ".sig"
    totalSize += getFileSize(p & ".sig")

let (totalSizeHuman, totalSizePrefix) = humanReadable(totalSize)

# TODO opt to show/hide total filesize
stderr.writeLine(fmt"Total file size: {totalSizeHuman:0.1f} {totalSizePrefix}B")
