#!/bin/bash
echo '  test
test  
	test' > testfile.c # last line is a TAB!
../stylecheck -f testfile.c &> output
echo 'error: testfile.c:2: trailing whitespace at end of line:
test  
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
