import std/[algorithm,math,os,parseopt,sequtils,strformat,strutils,sugar,tables]

func alpm_pkg_vercmp(a: cstring; b: cstring): cint {.dynlib: "libalpm.so", importc.}
func verCmp(a: string, b: string): int = alpm_pkg_vercmp(a, b)

func `/`(x, y: BiggestInt): BiggestFloat = toBiggestFloat(x) / toBiggestFloat(y)

func pkginfo(s: string): (string, string, string) =
  # don't split more than 3 times, because package names can have '-'
  let splits = s.rsplit('-', maxsplit=3)
  if (splits.len > 3):
    return (splits[0], splits[1], splits[2])
  return ("", "", "")

# TODO arbitrary precision math (bigints? stint?)
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

proc showHelp() =
  stderr.writeLine("TBI") # TODO implement
  quit()

var
  optParser = initOptParser(shortNoVal = {'h'}, longNoVal = @["help", "file-size", "file-size-bytes"])
  argCount = 0
  optCountToKeep = 1
  optDir = "."
  optFileSize: bool
  optFileSizeBytes: bool

for kind, key, val in optParser.getopt():
  case kind
  of cmdArgument:
    if (argCount >= 1):
      quit("too many arguments", 1)
    optDir = key
    inc argCount
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": showHelp()
    of "file-size":
      optFileSize = true
      optFileSizeBytes = false
    of "file-size-bytes":
      optFileSize = false
      optFileSizeBytes = true
    of "count", "c":
      try:
        let c = parseInt(val)
        if c < 1:
          quit("count must be positive", 2)
        optCountToKeep = c
      except ValueError:
        quit("count must be a positive integer", 3)
  of cmdEnd: discard # impossible

if not dirExists(optDir):
  quit(fmt"Path {optDir} does not exist", -1)

let
  fileList = collect(newSeq):
    for kind, path in walkDir(optDir, true, true):
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
  # TODO check if count exceeds seq size
  packageMap[p].delete(0..(optCountToKeep-1))
  toDelete = toDelete.concat(packageMap[p].map(x => x[1]))

var totalSize: BiggestInt
for p in toDelete:
  echo p
  totalSize += getFileSize(fmt"{optDir}/{p}")
  if fileList.contains(fmt"{p}.sig"):
    echo p & ".sig"
    totalSize += getFileSize(fmt"{optDir}/{p}.sig")

# TODO don't calculate file size if not requested?
if optFileSize:
  let (totalSizeHuman, totalSizePrefix) = humanReadable(totalSize)
  stderr.writeLine(fmt"Total file size: {totalSizeHuman:0.1f} {totalSizePrefix}B")
elif optFileSizeBytes:
  stderr.writeLine(fmt"Total file size: {totalSize} B")


# TODO repo mode for cleaning repos
