#!/bin/bash
echo '#include <stdio.h> 

void main()
{
	int i=0; 
	int *k;	
	k = &i;
	*k++;	
} 
' > testfile.c # last line is a TAB!
../stylecheck testfile.c &> output
echo 'error: testfile.c:1: trailing whitespace at end of line:
#include <stdio.h> 

error: testfile.c:5: trailing whitespace at end of line:
	int i=0; 

error: testfile.c:6: trailing whitespace at end of line:
	int *k;	

error: testfile.c:8: trailing whitespace at end of line:
	*k++;	

error: testfile.c:9: trailing whitespace at end of line:
} 
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
