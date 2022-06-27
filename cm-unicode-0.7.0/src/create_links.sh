#!/bin/sh
#
# Script for generation of required symbolic links
#
# Copyright (C) 2005 Andrey V. Panov
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
# concrete
font_vars="obi obx orm oti bbx bmo bmr bso bsr bxo btl bto"
font_size_init="10"
for font_var in $font_vars ; do
  for suffix in pfb tfm ; do
    ln -s e$font_var$font_size_init"."$suffix ec$font_var$font_size_init"."$suffix
    ln -s t$font_var$font_size_init"."$suffix tc$font_var$font_size_init"."$suffix
  done
done
   
for font_var in a x ; do
  for suffix in pfb tfm ; do
    ln -s tip$font_var$font_size_init"."$suffix tip$font_var"r"$font_size_init"."$suffix
  done
done
vnlinks(){
 ln -s vn${1}10.pfb vn${2}10.pfb
 ln -s vn${1}10.tfm vn${2}10.tfm
}
vnlinks "b" "rb" 
vnlinks "bxsl" "bl" 
vnlinks "bxti" "bi" 
vnlinks "itt" "it" 
vnlinks "r" "rm" 
vnlinks "sltt" "st" 
vnlinks "ssbx" "sx" 
vnlinks "ssi" "si" 
vnlinks "u" "ui" 
vnlinks "vtt" "vt" 

ln -s eobi10.mf ecobi10.mf