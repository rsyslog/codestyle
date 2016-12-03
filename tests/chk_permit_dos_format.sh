#!/bin/bash
echo -e 'Hello\r
this\r\r
is \r
a	\r
\r
test for\r
enableing 
dos\n 
format
' > testfile.c # last line is a TAB!
../stylecheck --permit-dos-format testfile.c &> output
echo -e 'error: testfile.c:2: trailing whitespace at end of line:
this\r\r

error: testfile.c:3: trailing whitespace at end of line:
is \r

error: testfile.c:4: trailing whitespace at end of line:
a	\r

error: testfile.c:7: trailing whitespace at end of line:
enableing 

error: testfile.c:9: invalid indention (SP at column 1):
 
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
