#!/bin/bash
echo '#include <stdio.h>

void main()
{
	int variable1=2;
	int variable2=5;
							if( variable1 < variable2 || variable1 == variable2 || variable1 > variable2) {

	}
}
' > testfile.c # last line is a TAB!
../stylecheck -wf testfile.c &> output
echo 'error: testfile.c:7: line too long (136):
Length of tabs: 49
							if( variable1 < variable2 || variable1 == variable2 || variable1 > variable2) {
' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
