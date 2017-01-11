#!/bin/bash
echo '#include <stdio.h>

void main()
{
	int i=0;  
	int k;	
        k=1;
}
' > testfile.c
../stylecheck -w testfile.c &> output
echo 'error: testfile.c:7: invalid indention (SP at column 1):
        k=1;
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1;
fi;

rm testfile.c output
