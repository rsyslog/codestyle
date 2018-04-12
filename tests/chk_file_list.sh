#!/bin/bash
echo '  test1
test
	test' > testfile.c
echo 'test
test2
	test' > testfile2.c
echo 'test
	test
  test3' > testfile3.c

../stylecheck -a file-list testfile.c testfile2.c testfile3.c &> output

echo 'FAIL: testfile.c
SUCCESS: testfile2.c
FAIL: testfile3.c' | diff - file-list
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! file-list is:"
  cat file-list
  exit 1
fi;

echo 'Success'

rm testfile.c testfile2.c testfile3.c file-list output
