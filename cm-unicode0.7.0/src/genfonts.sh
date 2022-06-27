#!/bin/bash
#
# Script for generation of pfb fonts from metafont ones using textrace or mftrace
#
# Copyright (C) 2002, 2003, 2004, 2005 Andrey V. Panov
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#
# For use with textrace place it inside textrace tree and save trace2.ps 
# before the first run. 
# When this script is invoked with -g option it generates Greek fonts,
# with -tipa option it traces tipa fonts and
# otherwise it does latin and cyrillic ones.
#
TRACE="mftrace" # Comment this line to use textrace
#MFTRACE_BACKEND_OPTIONS="-O 0.8" # for potrace
#PATH=`pwd`:$PATH # if gs binary is placed in textrace tree
#PATH=/opt/texmf/bin/:$PATH # path to teTeX-2.99
if [ "$1" = "-g" ]
then
#font_vars="bi bo xn bn mn mo mi" # Greek proportional
# font_vars="rxi rxo rxn rmn rmo rmi smi sxo smn sxn tti tto ttn sme sxe rmu tbn tbi sdn" # Greek
 font_vars="rxk rxq rxn rmn rmq rmk smn sxn sxo ttk ttq ttn smi sxi rmv tbn tbk sdn rms orm obx oti obi bbx bmo bmr bso bsr bxo btl bto" # Greek
# font_vars="bbx bmo bmr bso bsr bxo btl bto" # Greek
# font_vars="rxk rxq rmq rmk ttk ttq tbk" # Greek modified slanted
 font_bases="g" # Greek 
# font_vars="btl bto"
# font_vars="bbx bmo bmr bso bsr bxo btl bto"
# font_vars="sxo"
elif [ "$1" = "-tipa" ]
then
 font_vars="null sl bx bs ss sb si b tt ts orm obx bbx bmo bmr bso bsr bxo"
# font_vars="bbx bmo bmr bso bsr bxo"
 font_bases="tipa tipx"
elif [ "$1" = "-workaround" ]
then
 font_vars="ti ui ci bx rb bl"
 font_bases="tc"
elif [ "$1" = "-sc" ]
then
 MAGNIFICATION=2200
 export MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.1 -tangent-surround 15 -remove-adjacent-corners"
 MFTRACE_OPTIONS="--formats=pfb --autotrace --noround --grid 1000"
 font_size=1000
 font_vars="cc sc oc xc"
 echo "MFTRACE_BACKEND_OPTIONS="$MFTRACE_BACKEND_OPTIONS " magnification="$MAGNIFICATION " MFTRACE_OPTIONS="$MFTRACE_OPTIONS
 for f_v in ${font_vars}; do
  mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e ecsc.enc ec$f_v$font_size
  mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS --keep-trying -e uxsc.enc ux$f_v$font_size
 done
 mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e ecsc.enc eocc10
 mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS --keep-trying -e uxsc.enc uxocc10
 font_vars="rmc rxc" 
 MAGNIFICATION=2200 
 MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.1 -tangent-surround 15 -remove-adjacent-corners"
 MFTRACE_OPTIONS=$MFTRACE_OPTIONS" --glyphs=9-11,21,60,62,64-90,92,94-98,100-117,119-126,147,240,247-250"
 for f_v in ${font_vars}; do
  mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e gsc.enc g$f_v$font_size
 done
 MAGNIFICATION=2200 
 MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 125 -error-threshold 0.5 -line-reversion-threshold 0.5  -tangent-surround 15 -remove-adjacent-corners"
 mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e gsc.enc gsmc$font_size
 MAGNIFICATION=2050
 mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e gsc.enc gsxc$font_size
 MAGNIFICATION=2400 
 MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 120 -error-threshold 0.3 -line-reversion-threshold 0.1  -tangent-surround 15 -remove-adjacent-corners"
 mftrace --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e gsc.enc gttc$font_size
elif [ "$1" = "-vn" ]
then
 font_vars_base="b bx bxsl bxti itt r sl sltt ss ssbx ssdc ssi ti tt u vtt" #  csc tcsc
 font_vars_add="so vi tb tx ci" 
 font_vars_concrete="obx orm oti obi" # concrete
 font_vars_bright="bbx bmo bmr bso bsr bxo btl bto" # cmbright
 font_vars="$font_vars_base $font_vars_add $font_vars_concrete $font_vars_bright"
 font_bases="vn"
else
 font_vars_roman="bi bl bx rb rm sl ti ui" # Roman
 font_vars_typewriter="tt st it vt vi tb tx" # Typewriter
 font_vars_serif="ss ssdc si so sx ci " # Sans Serif
 font_vars_concrete="obx orm oti obi" # concrete
 font_vars_bright="bbx bmo bmr bso bsr bxo btl bto" # cmbright
# font_vars_serif="ss si so sx ci " # Sans Serif
# font_vars_quotation="lq lo li lb" # Quotation
 font_vars="$font_vars_roman $font_vars_typewriter $font_vars_serif $font_vars_quotation $font_vars_concrete $font_vars_bright"
# font_vars="bxo"
 font_bases="ux ec la rx tc lc lb ld" 
# font_bases="tc"
fi
#font_vars="lq lo li lb"
#font_vars="ci"
#font_base="gr" # Greek roman
#font_base="gs" # Greek serif
#font_base="gt" # Greek typewriter
#font_base="g" # Greek 
#font_base="tc"
#font_bases="ec"
#font_bases="la"
#font_base="rs"
#font_base="ld"
#font_base="rx"
font_size_init="1000"
#font_size_init="10"
#font_size_init="8"
f_v_run=""
let font_id=4000000+RANDOM*RANDOM/1500
for font_base in $font_bases ; do
 for f_v in ${font_vars}; do
  if [ $f_v = "null" ]
  then
   f_v_run=""
  else
   f_v_run=$f_v
  fi
  if [ $f_v = "ssdc" -o "$1" = "-tipa" -o $f_v = "orm" -o $f_v = "obx" -o $f_v = "oti" -o $f_v = "obi" \
       -o $f_v = "btl" -o $f_v = "bto" -o $f_v = "bbx" -o $f_v = "bmo" -o $f_v = "bmr" \
       -o $f_v = "bso" -o $f_v = "bsr" -o $f_v = "bxo" -o "$1" = "-vn" ]
  then
    font_size="10"
  elif [ $f_v = "lq" -o $f_v = "lo" -o $f_v = "li" -o $f_v = "lb" ]
  then
    font_size="8"
  else
    font_size=$font_size_init
  fi
  if [ $TRACE = "mftrace" ]
  then
    if [ -z $MFTRACE ]
    then
      MFTRACE="mftrace"
    fi
#   if [ $font_base = "bi" -o $font_base = "rxi" ]
#   then
#     MFTRACE_BACKEND_OPTIONS="-O 1"
#     MFTRACE_OPTIONS=" --magnification=2700 --noround --grid 100"
#   if [ $font_base = "rm" -o $font_base = "" ]
#   then
#     MAGNIFICATION=2500
#     MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 120 -error-threshold 0.5 -line-reversion-threshold 0.7"
#     MFTRACE_OPTIONS="--magnification=2500 --autotrace --noround --grid 1000"
   # Italic fonts
   if [ $f_v = "ti" -o $f_v = "ui" -o $f_v = "rmi" -o $f_v = "ci" \
        -o $f_v = "rmu" -o $f_v = "rmk" -o $f_v = "rms" -o $f_v = "oti"  -o $f_v = "u" ]
   then
     MAGNIFICATION=2300 # a bug with onehalf at higher magnifications
     #MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 120 -error-threshold 0.5 -line-reversion-threshold 0.1"
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.1" # ? W, f -
     #MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.3 -line-reversion-threshold 0.1" # ? W
     if [ "$1" = "-workaround" ]
     then
       MAGNIFICATION=2050 # a bug with onehalf at higher magnifications
     fi
   # Bold Italic fonts
   elif [ $f_v = "bi" -o $f_v = "rxi" -o $f_v = "rxk" -o $f_v = "obi" -o $f_v = "bxti" ]
   then
     MAGNIFICATION=2300 # !bold, 2500
     #MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 120 -error-threshold 0.5 -line-reversion-threshold 0.1"
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.1"
     if [ $font_base = "tc" -a $f_v = "obi" ] ; then
       MAGNIFICATION=2200
     fi
     if [ "$1" = "-workaround" ]
     then
       MAGNIFICATION=2050 # a bug with onehalf at higher magnifications
     fi
   # Roman with slanted, concrete fonts
   elif [ $f_v = "bx" -o $f_v = "rm" -o $f_v = "rb" -o $f_v = "bl" -o $f_v = "sl" -o \
          $f_v = "rxo" -o $f_v = "rxn" -o $f_v = "rmn" -o $f_v = "rmo" -o $f_v = "null" \
	  -o $f_v = "bs" -o $f_v = "b" -o $f_v = "rxq" -o $f_v = "rmq" \
	  -o $f_v = "orm" -o $f_v = "obx"  -o $f_v = "bxsl" -o $f_v = "r" ]
   then
     MAGNIFICATION=2200 # !bold, 2700
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.1 -tangent-surround 15 -remove-adjacent-corners"
     if [ "$1" = "-workaround" ]
     then
       MAGNIFICATION=2050 # a bug with onehalf at higher magnifications
     fi
   # Typewriter fonts
   elif [ $f_v = "tt" -o $f_v = "it" -o $f_v = "st" -o $f_v = "tb" -o $f_v = "tx" -o $f_v = "vt" \
          -o $f_v = "vi" -o $f_v = "tti" -o $f_v = "tto" -o $f_v = "ttn" -o $f_v = "tbn" \
	  -o $f_v = "tbi" -o $f_v = "ttk" -o $f_v = "ttq" -o $f_v = "tbk" -o $f_v = "ts" \
	   -o $f_v = "itt"  -o $f_v = "sltt" -o $f_v = "vtt" ]
   then
     MAGNIFICATION=2400 # !vi vt 3250
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 120 -error-threshold 0.3 -line-reversion-threshold 0.1  -tangent-surround 15 -remove-adjacent-corners"
   # Typewriter light fonts
   elif [ $f_v = "btl" -o $f_v = "bto" ]
   then
     MAGNIFICATION=3000 
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.3 -line-reversion-threshold 0.1  -tangent-surround 15 -remove-adjacent-corners"
   # Sans serif, bright fonts
   elif [ $f_v = "ss" -o $f_v = "si" -o $f_v = "so" -o \
          $f_v = "smi" -o $f_v = "sxo" -o $f_v = "smn" -o \
	  $f_v = "sme" -o $f_v = "sxe" -o $f_v = "sxa" \
	    -o $f_v = "ssi" \
	  -o $f_v = "bbx" -o $f_v = "bmo" -o $f_v = "bmr" -o $f_v = "bso" -o \
	  $f_v = "bsr" -o $f_v = "bxo" ]
   then
     MAGNIFICATION=2200 # ! slanted 2400
     #MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.5  -tangent-surround 15 -remove-adjacent-corners" # non-curve outlines e.g. in y
     #							caron in bright fonts!
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 125 -error-threshold 0.5 -line-reversion-threshold 0.5  -tangent-surround 15 -remove-adjacent-corners"
     if [ $f_v = "sxo" -o $f_v = "bbx" -o $f_v = "bxo"  -o $f_v = "ssbx" ]
     then
       MAGNIFICATION=2050
     fi
   elif [ $f_v = "sx" -o $f_v = "sxn" -o $f_v = "sb" -o $f_v = "ssbx" -o $f_v = "ssdc" -o $f_v = "sdn" ]
   then
     MAGNIFICATION=2250
     #MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 120 -error-threshold 0.2 -line-reversion-threshold 0.5  -tangent-surround 15 -remove-adjacent-corners"
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 150 -corner-threshold 118 -error-threshold 0.5 -line-reversion-threshold 0.1 -remove-adjacent-corners"
     if [ $f_v = "sx" -o $f_v = "sxn" -o $f_v = "sb" -o $f_v = "ssbx" ]
     then
       MAGNIFICATION=2050
     fi
   else
     MAGNIFICATION=1000
     MFTRACE_BACKEND_OPTIONS="-filter-iterations 100 -corner-threshold 120 -error-threshold 0.3 -line-reversion-threshold 0.1"
   fi
#   export MFTRACE_OPTIONS="-b --autotrace --noround --grid 1000" # mftrace-1.0
   export MFTRACE_OPTIONS="--formats=pfb --autotrace --noround --grid 1000"
#   MFTRACE_OPTIONS="-b"
#   MFTRACE_OPTIONS="-b --autotrace --glyphs=65,66,98,109,120 --noround --grid 1000"
#    mftrace --potrace -b -e $font_base.enc --magnification=1000 --glyphs=65,66,98,109,120 $font_base$f_v$font_size
   if [ $font_base = "lc" ]
   then
    MFTRACE_OPTIONS="$MFTRACE_OPTIONS --glyphs=134,142,147,148,155,166,174,179,180,187"
   elif [ $font_base = "lb" ]
   then
    MFTRACE_OPTIONS="$MFTRACE_OPTIONS --glyphs=128,130,145,148,160,162,177,180"
   fi
   if [ $font_base = "ux" -o $font_base = "ld" -o \( $font_base = "tc" -a $f_v = "so" \) ]
   then
    MFTRACE_OPTIONS="$MFTRACE_OPTIONS --keep-trying"
   fi
   if [ "$1" = "-workaround" ]
   then
    MFTRACE_OPTIONS="--autotrace --noround --grid 1000 --glyphs=185,188,189,190" #--output-base=t_$f_v_run$font_size"
   fi
   font_base_run=$font_base
   if [ $f_v = "orm" -o $f_v = "obx" -o $f_v = "oti" -o $f_v = "obi" \
        -o $f_v = "btl" -o $f_v = "bto" -o $f_v = "bbx" -o $f_v = "bmo" -o $f_v = "bmr" \
        -o $f_v = "bso" -o $f_v = "bsr" -o $f_v = "bxo" ] ; then
     if [ $font_base = "tc" ] ; then
      font_base_run="t"
     elif [ $font_base = "ec" ] ; then
      font_base_run="e"
     fi
   fi
#   MFTRACE_BACKEND_OPTIONS="" mftrace --potrace -e $font_base.enc --magnification=1000 $MFTRACE_OPTIONS $font_base$f_v_run$font_size
   echo "MFTRACE_BACKEND_OPTIONS="$MFTRACE_BACKEND_OPTIONS " magnification="$MAGNIFICATION " MFTRACE_OPTIONS="$MFTRACE_OPTIONS
   export MFTRACE_BACKEND_OPTIONS
   $MFTRACE --magnification=$MAGNIFICATION $MFTRACE_OPTIONS -e $font_base.enc $font_base_run$f_v_run$font_size
  else
    ln -sf trace2.ps.$font_base trace2.ps
    traceall.sh $font_base$f_v$font_size $font_base$f_v$font_size.pfb $font_id
    ./contrib/tfm2kpx.pl $font_base$f_v$font_size > $font_base$f_v$font_size.kpx
    ./contrib/t12afm.sh $font_base$f_v$font_size.pfb $font_base$f_v$font_size.kpx >$font_base$f_v$font_size.afm
  fi
  let font_id++
 done
done

