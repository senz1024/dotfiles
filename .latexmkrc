#!/usr/bin/env perl
$latex='platex -shell-escape -synctex=1 %O %S';
$bibtex='pbibtex %O %S';
$dvipdf='dvipdfmx %O -o %D %S';
$makeindex='mendex %O -o %D %S';
$max_repeat=5;
