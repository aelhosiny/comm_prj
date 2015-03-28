#/bin/sh

drawtiming -o $1.eps $1.tm -w 20 -c 15 -l 1 -f 10 ; epstopdf $1.eps
