#!/bin/sh

# This script for version 3.4
# A script to install LH fonts in X2, T2A, T2B, T2C, T2D encodings
# and optionally also LCY and OT2 encodings
# for web2c-based TeX systems (and teTeX is among them)

# stop on any error
set -e

# Uncomment the following line to install ALL *.mf header files
# (see the `INSTALL' file for explanation):
#perl -p -i -e 's/\\MakeFileHeadsfalse/\\MakeFileHeadstrue/' tex/setter.tex
#perl -p -i -e 's/\\SliTeXfalse/\\SliTeXtrue/' tex/setter.tex
#perl -p -i -e 's/\\Concretefalse/\\Concretetrue/' tex/setter.tex
#perl -p -i -e 's/\\CMBrightfalse/\\CMBrighttrue/' tex/setter.tex
#perl -p -i -e 's/\fntbercm/\fntallcm/' tex/setter.tex
#perl -p -i -e 's/\fntberec/\fntallec/' tex/setter.tex

TEXMF=`kpsewhich -expand-var='$TEXMFMAIN'`
FONTS=$TEXMF/fonts/source/lh
DOC=$TEXMF/doc/fonts/lh

inst_lh_fonts() {
	echo "Installing LH fonts for the `echo $2 | tr '[:lower:]' '[:upper:]'` encoding..."
	tex $1.tex > /dev/null
	mkdir $FONTS/lh-$2
	cp wrk/*.mf $FONTS/lh-$2	# ??{codes,liker,begin}.mf
	rm -f $1.dvi $1.log wrk/*
}

abort() {
  echo Aborting. Please, remove old versions of LH fonts manually
  echo and re-run this script.
#  exit 1
}

if ( echo "a\c"; echo a ) | grep c >/dev/null; then
  ac_n=-n ac_c=
else
  ac_n= ac_c='\c'
fi

echon () {
  echo $ac_n "$*"$ac_c
}

# Remove old version(s) of LH fonts
echo Looking for old version of LH fonts...
(
kpsewhich -expand-path="`kpsewhich -show-path=tfm`"
kpsewhich -expand-path="`kpsewhich -show-path=mf`"
kpsewhich -expand-path="`kpsewhich -show-path=vf`"
kpsewhich -expand-path="`kpsewhich -show-path=pk`"
kpsewhich -expand-path="`kpsewhich -show-path='TeX system documentation'`"
) | tr ':' '\n' | grep '/lh$' | sort -u > .tmp
dirs=`cat .tmp`
rm -f .tmp
if test -n "$dirs"; then
echo "The following directories found which contain old version of LH fonts:"
echo
echo $dirs | tr ' ' '\n'
echo
echon "Remove them? [y/n] "
read reply
if test "$reply" = y; then
  rm -rf $dirs
else
  abort
fi
fi
kpsewhich ldcsc.mf >/dev/null && abort

if test -d $FONTS; then
	echo Installation directory $FONTS already exists.
	echon "Execute command \"rm -rf $FONTS\"? [y/n] "
	read reply
	if test "$reply" = y; then
		rm -rf $FONTS
	else
		abort
	fi
fi

echo Installing main METAFONT files...
mkdir -p $FONTS
(cd ../../fonts/source/lh; tar cf - .) | (cd $FONTS; tar xf -)
# cp -r fonts/* $FONTS

cd tex
test -d wrk || mkdir wrk
rm -f wrk/*

# Generate and install METAFONT headers for LH fonts in X2 encoding
# and T2A, T2B, T2C, T2D encodings.
# Font header files for SliTeX are also generated.
inst_lh_fonts 12ex-la t2a
inst_lh_fonts 13ex-lb t2b
inst_lh_fonts 14ex-lc t2c
inst_lh_fonts 15ex-ld t2d
inst_lh_fonts 11ex-rx x2

inst_lh_fonts 03cm-wn ot2	# OT2 7-bit encoding (as in AMS wncy fonts)
inst_lh_fonts 01cm-lh lcy	# similar to `New Alternative Variant' of cp866

# Other non-standard encodings (matching input encodings).
# These encodings are incompatible with the LaTeX standards.
# IT IS NOT RECOMMENDED TO INSTALL ANY OF THE FOLLOWING FONTS.
# It is better to use T2* encodings with the inputenc package instead.
#inst_lh_fonts 20cm-ct lct	# Tatarian variant of cp866
#inst_lh_fonts 21cm-ic lci	# ISO-8859-5
#inst_lh_fonts 22cm-wc lcw	# cp1251
#inst_lh_fonts 23cm-mc lcm	# Macintosh Ukrainian
#inst_lh_fonts 24cm-kc lck	# koi8-r

#inst_lh_fonts 30cm-lx llh	# extended cp866
#inst_lh_fonts 31cm-ix llh	# extended ISO-8859-5
#inst_lh_fonts 32cm-wx llh	# extended cp1251
#inst_lh_fonts 33cm-mx llh	# extended Macintosh Ukrainian
#inst_lh_fonts 34cm-kx llh	# extended koi8-r

#inst_lh_fonts 11ex-rs llh	# Old Slav Cyrillic not covered by T2D
inst_lh_fonts 25cm-uc llh	# Cyrillic Unicode page
#inst_lh_fonts 04cm-vf llh	# 7-bit encoding (for virtual fonts)
#inst_lh_fonts 46cm-ly llh	# OT2u
#inst_lh_fonts 46cm-lz llh	# OT2l
#inst_lh_fonts 47ex-tx llh	# All non-X2 letters & signs

cd ..
echo Installing documentation files...
mkdir -p $DOC
(cd ../../doc/fonts/lh/; tar cf - .) | (cd $DOC; tar xf -)

# Update TeX hash
mktexlsr
