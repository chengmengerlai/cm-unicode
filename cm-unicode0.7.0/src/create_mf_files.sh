#!/bin/sh
#
# Script for generation of required metafont files
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
# Greek
for font_base in rxk rxq rmq rmk ttk ttq tbn tbk sdn rms rmv ; do
 cat << EOF > "g"${font_base}"1000.mf"
input cbgreek;
EOF
done
# Cyrillic concrete
font_vars="obi obx"
font_bases="la rx lc ux lb ld" 
for font_base in $font_bases ; do
 for f_v in ${font_vars}; do
  cat << EOF > ${font_base}${f_v}"10.mf"
def concrete=true enddef;
input fikparm;
EOF
 done
done

for font_base in orm oti occ ; do
  cat << EOF > ux${font_base}10.mf
def concrete=true enddef;
input fikparm;
EOF
done
   
