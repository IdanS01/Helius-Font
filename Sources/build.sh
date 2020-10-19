#!/bin/sh
set -e

mkdir -p ../Fonts/otf ../Fonts/ttf

echo = "Generating TTFs"
fontmake -u UFO/Helius-Light.ufo -o ttf --output-dir ../Fonts/ttf -a
fontmake -u UFO/Helius-Regular.ufo -o ttf --output-dir ../Fonts/ttf -a
fontmake -u UFO/Helius-Medium.ufo -o ttf --output-dir ../Fonts/ttf -a
fontmake -u UFO/Helius-Bold.ufo -o ttf --output-dir ../Fonts/ttf -a
fontmake -u UFO/Helius-Black.ufo -o ttf --output-dir ../Fonts/ttf -a


echo = "Post procesing TTF"
ttfs=$(ls ../Fonts/ttf/*.ttf)
for ttf in $ttfs
do
    gftools fix-hinting $ttf
    mv "$ttf.fix" $ttf
    gftools fix-dsig -f $ttf;
done

echo = "Generating OTFs"
fontmake -u UFO/Helius-Light.ufo -o otf --output-dir ../Fonts/otf
fontmake -u UFO/Helius-Regular.ufo -o otf --output-dir ../Fonts/otf
fontmake -u UFO/Helius-Medium.ufo -o otf --output-dir ../Fonts/otf
fontmake -u UFO/Helius-Bold.ufo -o otf --output-dir ../Fonts/otf
fontmake -u UFO/Helius-Black.ufo -o otf --output-dir ../Fonts/otf

echo "Post processing static OTFs"
otf=$(ls ../Fonts/otf/*.otf)
for otf in $otf
do
	gftools fix-dsig -f $otf;
    #psautohint $otf;
done

echo "Done!"