### Computer Modern Unicode fonts


Computer Modern Unicode fonts were converted from metafont sources using mftrace with autotrace backend and fontforge (former pfaedit). Their main purpose is to create free good quality fonts for use in X applications supporting many languages. Currently the fonts contain glyphs from Latin1 (Metafont ec, tc, vnr), Cyrillic (lh) and Greek (cbgreek when available) code sets and IPA extensions (from tipa). Other alphabets are also welcome. Now this set contains 33 fonts. It is better to use these fonts with antialiasing enabled.

Here you can see Unicode glyph coverage in [CMUSerif-Roman](https://cm-unicode.sourceforge.io/cmunrm.pdf) (pdf ~600kb) and [CMUSerif-Italic](https://cm-unicode.sourceforge.io/cmunti.pdf) fonts.

Look at this [table](https://cm-unicode.sourceforge.io/font_table.html) for more description.

Since version 0.7.0 the license is changed to [SIL Open Font License (OFL)](scripts.sil.org/OFL).

The latest development version is 0.7.0.

There is project page for the fonts at [SourceForge.net](https://sourceforge.net/projects/cm-unicode/).

### News


CM Unicode 0.7.0 (June 18 2009) (Development release)

    License changed to OFL 1.1
    Converted to lookups for Advanced Typography
    Changed building of accented characters, it is now based on anchors
    Added special accents for capital letters
    Added small serifs to U+26A in sans-serif fonts
    Reencoded U+478 and U+479 as U+A46A, U+A46B
    Kerning copied to built accented characters
    Added experimental truetype fonts with autoconverted instructions
    Tarballs now compressed with xz (use xz or 7-Zip for decompression)

### Installation



Installation for XFree86 (X.Org)

Unpack the archive file containing fonts in some temporal directory, for example /tmp :




```
cd /tmp
tar xzvf cm_unicode-VERSION-pfb.tar.gz
cd cm-unicode-VERSION

```

where VERSION is version number of this font pack. Then create cm-unicode/ directory at the place, where your X stores fonts, for example /usr/X11R6/lib/X11/fonts :

`mkdir -p /usr/X11R6/lib/X11/fonts/cm-unicode`

You should become root to do it. Then copy font files there:


```
cp *.afm /usr/X11R6/lib/X11/fonts/cm-unicode/
cp *.pfb /usr/X11R6/lib/X11/fonts/cm-unicode/
```


If you are using XFree86 prior to 4.3 you should also copy fonts.scale there. Then change directory to /usr/X11R6/lib/X11/fonts/cm-unicode/ :

```
cd /usr/X11R6/lib/X11/fonts/cm-unicode/
```


and do


```
mkfontscale # if you are using XFree86-4.3 or later or recent X.Org
mkfontdir
```


Currently mkfontscale and mkfontdir may produce errors, so copy fonts.dir and fonts.scale files supplied into /usr/X11R6/lib/X11/fonts/cm-unicode/

Then add

`FontPath     "/usr/X11R6/lib/X11/fonts/cm-unicode/" `

to "Files" Section of etc/X11/xorg.conf (/etc/X11/XF86Config). On the next run X.Org (XFree86) will load these fonts.

If you are using fontconfig (X.Org, XFree86-4.3, may be installed on XFree86-4.2) you should add a line

`<dir>/usr/X11R6/lib/X11/fonts/cm-unicode</dir>`

to /etc/fonts/fonts.conf or better to /etc/fonts/local.conf then run

`fc-cache`

Installation for ghostscript

Assuming that you have rather new ghostscript version like 7.x go to default ghostscript font directory, typically /usr/share/ghostscript/fonts, then add links to fonts installed for X or copy them:


```
cd /usr/share/ghostscript/fonts
ln -s /usr/X11R6/lib/X11/fonts/cm-unicode/*.afm .
ln -s /usr/X11R6/lib/X11/fonts/cm-unicode/*.pfb .
```


Then go to the ghostscript library directory, for example

`cd /usr/share/ghostscript/?.??/lib`

where ?.?? is ghostscript version. Copy Fontmap.CMU from tarball:

```
cp /tmp/cm-unicode-VERSION/Fontmap.CMU
```
 .

Then add following line to Fontmap file:

`(Fontmap.CMU) .runlibfile`
