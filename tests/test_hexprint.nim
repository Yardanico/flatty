import flatty/binny, flatty/hexprint, osproc, streams

var s = newFileStream("tests/test_hexprint-output.txt", fmWrite)

block:
  s.writeLine "Sentence:"
  s.writeLine hexPrint("Hi how are you doing today?")

block:
  s.writeLine "ASCII:"
  var bin = ""
  for i in 0 .. 255:
    bin.add chr(i)
  s.writeLine hexPrint(bin)

block:
  s.writeLine "int16s:"
  var bin = ""
  for i in 0 .. 16:
    bin.addUint16(i.uint16)
  s.writeLine hexPrint(bin)

block:
  s.writeLine "int32s"
  var bin = ""
  for i in 0 .. 16:
    bin.addUint32(1000 * i.uint32)
  s.writeLine hexPrint(bin)

s.close()

let (outp, _) = execCmdEx("git diff tests/test_hexprint-output.txt")
if len(outp) != 0:
  echo outp
  quit("Output does not match")
