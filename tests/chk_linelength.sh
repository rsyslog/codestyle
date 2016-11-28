#!/bin/bash
echo '#include <stdio.h>

void main()
{
	int variable1=2;
	int variable2=5;
	if(( variable1 < variable2 || variable1 = variable2 ) && variable2 > variable2 - variable1 && variable2 != 0 && ( variable1 == 2 || variable1 == 3 ) && (variable2 == 4 || variable 2 == 5)) {

	}
}
' > testfile.c # last line is a TAB!
../stylecheck testfile.c &> output
echo 'error: testfile.c:7: line too long:
	if(( variable1 < variable2 || variable1 = variable2 ) && variable2 > variable2 - variable1 && variable2 != 0 && ( variable1 == 2 || variable1 == 3 ) && (variable2 == 4 || variable 2 == 5)) {
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
