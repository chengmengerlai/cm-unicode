#!/bin/sh
#PATH=/opt/texmf/bin/:$PATH # path to teTeX-2.99
if [ "$1" = "-g" ]
then
#font_vars="bi bo xn bn mn mo mi" # Greek proportional
# font_vars="rxi rxo rxn rmn rmo rmi smi sxo smn sxn tti tto ttn sme sxe rmu tbn tbi sdn" # Greek
 font_vars="rxk rxq rxn rmn rmq rmk smn sxn ttk ttq ttn sme sxe rmu tbn tbk sdn rms rmv orm obx oti obi bbx bmo bmr bso bsr bxo btl bto" # Greek
# font_vars=$font_vars " orm obx oti obi"
# font_vars="rxk rxq rmq rmk ttk ttq tbk" # Greek modified slanted
 font_bases="g" # Greek 
# font_vars="sdn"
elif [ "$1" = "-tipa" ]
then
 font_vars="null sl bx bs ss sb si b tt ts orm obx bbx bmo bmr bso bsr bxo"
 font_bases="tipa tipx"
elif [ "$1" = "-sc" ]
then
 font_size=1000
 font_vars="cc sc oc xc"
 for f_v in ${font_vars}; do
  mktextfm ec$f_v$font_size
  mktextfm ux$f_v$font_size
 done
 mktextfm eocc10
 mktextfm uccsc10
else
 font_vars_roman="bi bl bx rb rm sl ti ui" # Roman
 font_vars_typewriter="tt st it vt vi tb tx" # Typewriter
 font_vars_serif="ss ssdc si so sx ci " # Sans Serif
# font_vars_serif="ss si so sx ci " # Sans Serif
# font_vars_quotation="lq lo li lb" # Quotation
 font_vars_concrete="obx orm oti obi" # concrete
 font_vars_bright="bbx bmo bmr bso bsr bxo btl bto" # cmbright
 font_vars="$font_vars_roman $font_vars_typewriter $font_vars_serif $font_vars_quotation $font_vars_concrete $font_vars_bright"
 font_bases="ec la rx tc lc ux lb" 
# font_bases="lc"
fi
font_size_init="1000"
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
       -o $f_v = "bso" -o $f_v = "bsr" -o $f_v = "bxo" ]
  then
    font_size="10"
  elif [ $f_v = "lq" -o $f_v = "lo" -o $f_v = "li" -o $f_v = "lb" ]
  then
    font_size="8"
  else
    font_size=$font_size_init
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
  if [ ! -f $font_base_run$f_v_run$font_size".tfm" ]
  then
   mktextfm $font_base_run$f_v_run$font_size".tfm"
  fi
 done
done
   
