#!/bin/bash
echo '  test
test
	test' > testfile.c # last line is a TAB!
echo 'test
 test
	test' > testfile2.c
../stylecheck testfile.c testfile2.c &> output
echo 'error: testfile.c:1: invalid indention (SP at column 1):
  test

error: testfile2.c:2: invalid indention (SP at column 1):
 test
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
