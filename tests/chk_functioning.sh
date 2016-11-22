#!/bin/bash
echo '#include <stdio.h>

void main()
{
	int i=0;
	int k=2;
	if(i<k) {
		i++;
	}
	k -= i;
}
' > testfile.c # last line is a TAB!
../stylecheck testfile.c &> output
echo -n '' | diff - output
if [ ! $? -eq 0 ]; then
  echo "invalid output generated! Output is:"
  cat output
  exit 1
fi;

rm testfile.c output
