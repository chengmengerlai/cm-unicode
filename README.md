### Computer Modern Unicode fonts


Computer Modern Unicode 字体是使用 mftrace 和 autotrace 后端和 fontforge（以前的 pfaedit）从metafont 转换而来的。它们的主要目的是创建免费的优质字体，用于支持多种语言的 X 应用程序。目前，字体包含来自 Latin1（Metafont ec、tc、vnr）、西里尔文（lh）和希腊文（cbgreek，如果可用）代码集和 IPA 扩展（来自tipa）的字形。也欢迎使用其他字母。现在这个集合包含 33 种字体。最好在启用抗锯齿的情况下使用这些字体。

在这里，你可以看到 [CMUSerif-Roman](https://cm-unicode.sourceforge.io/cmunrm.pdf) (pdf ~600kb) 和 [CMUSerif-Italic](https://cm-unicode.sourceforge.io/cmunti.pdf) 字体中的 Unicode 字形覆盖率。

查看[此表](https://cm-unicode.sourceforge.io/font_table.html)以获取更多说明。

从 0.7.0 版开始，许可证更改为 [SIL 开放字体许可证 (OFL)](https://scripts.sil.org/OFL)。

最新的开发版本是 0.7.0。

[SourceForge.net](https://sourceforge.net/projects/cm-unicode/) 上有字体的项目页面。

### 新闻
CM Unicode 0.7.0（2009 年 6 月 18 日）（开发版）

许可证更改为 OFL 1.1

转换为高级排版的查找

改变了重音字符的构建，它现在基于锚

为大写字母添加特殊重音

在无衬线字体的 U+26A 中添加了小衬线

将 U+478 和 U+479 重新编码为 U+A46A、U+A46B

字距复制到内置重音字符

添加了带有自动转换指令的实验性 Truetype 字体

tarball 现在使用 xz 压缩（使用 xz 或 7-Zip 进行解压缩）

### 安装

XFree86 (X.Org) 的安装

在某个临时目录中解压缩包含字体的存档文件，例如 /tmp ：


```
cd /tmp
tar xzvf cm_unicode-VERSION-pfb.tar.gz
cd cm-unicode-VERSION

```

其中 VERSION 是此字体包的版本号。然后在 X 存储字体的地方创建 cm-unicode/ 目录，例如 /usr/X11R6/lib/X11/fonts ：

`mkdir -p /usr/X11R6/lib/X11/fonts/cm-unicode`

你应该成为 root 才能做到这一点。 然后在那里复制字体文件：


```
cp *.afm /usr/X11R6/lib/X11/fonts/cm-unicode/
cp *.pfb /usr/X11R6/lib/X11/fonts/cm-unicode/
```


如果您使用的是 4.3 之前的 XFree86，您还应该将 fonts.scale 复制到那里。  然后将目录更改为 /usr/X11R6/lib/X11/fonts/cm-unicode/ ：

```
cd /usr/X11R6/lib/X11/fonts/cm-unicode/
```

然后执行


```
mkfontscale # if you are using XFree86-4.3 or later or recent X.Org
mkfontdir
```


目前 mkfontscale 和 mkfontdir 可能会产生错误，因此请将提供的 fonts.dir 和 fonts.scale 文件复制到 /usr/X11R6/lib/X11/fonts/cm-unicode/

然后添加

`FontPath     "/usr/X11R6/lib/X11/fonts/cm-unicode/" `

到 etc/X11/xorg.conf (/etc/X11/XF86Config) 的“文件”部分。在下一次运行时，X.Org (XFree86) 将加载这些字体。

如果您使用的是 fontconfig（X.Org，XFree86-4.3，可能安装在 XFree86-4.2 上），您应该添加一行

`<dir>/usr/X11R6/lib/X11/fonts/cm-unicode</dir>`

到 /etc/fonts/fonts.conf 或更好到 /etc/fonts/local.conf 然后运行

`fc-cache`

安装 ghostscript

假设您有相当新的 ghostscript 版本，如 7.x，请转到默认的 ghostscript 字体目录，通常是 /usr/share/ghostscript/fonts，然后添加为 X 安装的字体的链接或复制它们：


```
cd /usr/share/ghostscript/fonts
ln -s /usr/X11R6/lib/X11/fonts/cm-unicode/*.afm .
ln -s /usr/X11R6/lib/X11/fonts/cm-unicode/*.pfb .
```


然后进入ghostscript库目录，例如

`cd /usr/share/ghostscript/?.??/lib`

?.?? 是ghostscript版本。从 tarball 复制 Fontmap.CMU：

```
cp /tmp/cm-unicode-VERSION/Fontmap.CMU
```
 .

然后将以下行添加到 Fontmap 文件：

`(Fontmap.CMU) .runlibfile`

### 警告


升级后运行

`fc-cache -f`

要使用 ps2pdf 脚本将这些字体嵌入到 pdf 文件中，您应该使用 ghostscript-8.x（8.15 可以）。

字体 CMUTypewriterVariable 和 CMUTypewriterVariable-Italic 由于家族名称过长，无法在 Windows 下安装。

0.4.1 之前的opentype 字体版本可能会导致Mac OS X 10.4 (Tiger) 下的应用程序崩溃。

目前 X 应用程序不完全支持 opentype 字体。大多数程序，例如基于 GNOME 或 qt-3.x 的程序 (KDE 3.x)，可以渲染 otf 字体但不能打印。

查看 libgnomeprint 的错误报告。

OpenOffice.org 根本不支持 otf 字体（[Issue 16032](http://www.openoffice.org/issues/show_bug.cgi?id=16032)）。

qt 4.1、scribus、inkscape 和 seamonkey (firefox 1.5) 支持使用 otf 字体打印。

作为使用 Qt 3.3 打印的一种解决方法，在 Ghostscript 的 Fontmap 文件中的 Fontmap.CMU 之后调用 Fontmap.CMU.alias。  它将替代一些字体。

过时的 mkfontscale 无法识别 Type 1 字体名称中的 SemiBold 样式选项。使用提供的 fonts.scale 文件。