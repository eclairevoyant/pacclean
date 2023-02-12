import std/[algorithm,os,sequtils,strutils,sugar,tables]
proc alpm_pkg_vercmp*(a: cstring; b: cstring): cint {.dynlib: "libalpm.so", importc.}
proc verCmp(a: string, b: string): int = alpm_pkg_vercmp(a, b)
proc verCmp(a: (string, string), b: (string, string)): int = verCmp(a[0], b[0])

proc pkginfo(s: string): (string, string, string) =
  var splits = s.rsplit('-', maxsplit=3)
  if (splits.len > 3):
    return (splits[0], splits[1], splits[2])
  return ("", "", "")

var
  packageList = toSeq(walkFiles("*.pkg.tar.zst"))
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

for p in packageMap.keys:
  sort(packageMap[p], verCmp, SortOrder.Descending)
  packageMap[p].delete(0..0)
  toDelete = toDelete.concat(packageMap[p].map(x => x[1]))

for p in toDelete:
  echo p
