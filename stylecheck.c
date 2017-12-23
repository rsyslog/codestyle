#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <unistd.h>
#include <getopt.h>
#include <libgen.h>
#include <stdlib.h>


static void
check_file(int *had_err, const char *fn, int dos, int trailing, int firstspace, int maxlen)
{
	FILE *fp;
	int ln_nbr;
	char ln[4096];
	int msgs = 0;
	int max_msgs = 20;
	int length;
	int position = 2;
	int pos;
	
	if ((fp = fopen (fn, "r")) == NULL) {
		perror (fn);
		*had_err = 1;
		return;
	}

	ln_nbr = 1;
	while (fgets (ln, sizeof(ln), fp) != NULL) {
		length = strlen(ln);
		if(ln[length-1] != '\n') {
			fprintf(stderr, "error: %s:%d: line is missing LF:\n%s\n", fn, ln_nbr, ln);
			*had_err = 1;
			++msgs;
			continue;
		}
		/* max line lenght */
		pos = 0;
		for(int i=0;i<length-1;i++) {
			++pos;
			if(ln[i]=='\t') {
				pos += (8 - pos % 8) % 8;
			}
		}
		if(pos > maxlen) {
			fprintf(stderr, "error: %s:%d: line too long (%d):\n%s\n",
				fn, ln_nbr, pos, ln);
			*had_err = 1;
			++msgs;
		}
		/* space at the beginning of line */
		if(firstspace) {
			if (ln[0] == ' ' && ln[1] != '*') {
				fprintf(stderr, "error: %s:%d: invalid indention (SP at column 1):"
					"\n%s\n", fn, ln_nbr, ln);
				*had_err = 1;
				++msgs;
			}
		}
		/* whitespace at the end of the line */
		if(trailing) {
			if(dos) {
				if(length > position && ln[length-1]=='\n' && ln[length-2]=='\r') {
					position = 3;
				}
				else {
					position = 2;
				}
			}
			if(length > position && isspace(ln[length-position])) {
				fprintf(stderr, "error: %s:%d: trailing whitespace at end of line:"
					"\n%s\n", fn, ln_nbr, ln);
				*had_err = 1;
				++msgs;
			}
		}
		/* line number + msg limit */
		++ln_nbr;
		if(msgs == max_msgs) {
			fprintf(stderr, "reached max %d messages, not reporting more\n",
				max_msgs);
			goto done;
		}
	}

done:
	fclose (fp);
}

int
main(int argc, char *argv[])
{
	int had_err = 0;
	int opt = 0;
	int dos = 0;
	int trailing = 1;
	int firstspace = 1;
	int maxlen = 120;
	char *ignore = NULL;
	static struct option long_options[] = {
		{"ignore", required_argument, 0, 'i'},
		{"permit-dos-format", no_argument, 0, 'd'},
		{"disable-trailing-whitespace", no_argument, 0, 'w'},
		{"disable-first-space", no_argument, 0, 'f'},
		{"set-maxlength", required_argument, 0, 'l'},
		{0, 0, 0, 0}
	};
	int long_index = 0;
	while((opt = getopt_long(argc, argv, "i:dwfl:", long_options, &long_index)) != -1) {
		switch(opt) {
		case 'i':
			ignore = optarg;
			break;
		case 'd':
			dos = 1;
			break;
		case 'w':
			trailing = 0;
			break;
		case 'f':
			firstspace = 0;
			break;
		case 'l':
			maxlen = atoi(optarg);
			break;
		default:
			break;
		}
	}

	for(int i = optind; i < argc ; ++i) {
		if(ignore == NULL || strcmp(basename(argv[i]), ignore) != 0) {
			check_file(&had_err, argv[i], dos, trailing, firstspace, maxlen);
		}
	}
	return had_err;
}
