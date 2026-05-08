#!/usr/bin/env bash
# Regenerate all Chrome extension icon sizes from the master design.
# Optical sizing:
#   - Large (96, 128): Didot + small subtle dot. Maximum elegance.
#   - Medium (48):     Didot + slightly enlarged dot. Survives downsample.
#   - Small (16, 32):  Baskerville (thicker strokes) + ~25% canvas dot. Legible at toolbar size.
# Requires ImageMagick.
set -e

cat > /tmp/_bg.svg <<SVG
<svg width="512" height="512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg">
  <rect width="512" height="512" rx="96" fill="#7f1d1d"/>
</svg>
SVG
magick -background none -density 300 /tmp/_bg.svg -resize 512x512 /tmp/_bg.png

DIDOT="/System/Library/Fonts/Supplemental/Didot.ttc"
BASKER="/System/Library/Fonts/Supplemental/Baskerville.ttc"

# LARGE source — Didot + small subtle dot (radius 16 on 512 canvas)
magick /tmp/_bg.png \
  -font "$DIDOT" -pointsize 600 -fill "#fef3c7" \
    -gravity center -annotate +0+100 "“" \
  -fill "#22d3ee" -stroke none -draw "circle 416,416 416,432" \
  /tmp/_large.png

# MEDIUM source — Didot + slightly larger dot (radius 28)
magick /tmp/_bg.png \
  -font "$DIDOT" -pointsize 600 -fill "#fef3c7" \
    -gravity center -annotate +0+100 "“" \
  -fill "#22d3ee" -stroke none -draw "circle 412,412 412,440" \
  /tmp/_medium.png

# SMALL source — Baskerville + large dot (radius 64, ~25% of canvas)
magick /tmp/_bg.png \
  -font "$BASKER" -pointsize 540 -fill "#fef3c7" \
    -gravity center -annotate +0+60 "“" \
  -fill "#22d3ee" -stroke none -draw "circle 384,400 384,464" \
  /tmp/_small.png

# Render at all manifest sizes
magick /tmp/_small.png  -resize 16x16   icon16.png
magick /tmp/_small.png  -resize 32x32   icon32.png
magick /tmp/_medium.png -resize 48x48   icon48.png
magick /tmp/_large.png  -resize 96x96   icon96.png
magick /tmp/_large.png  -resize 128x128 icon128.png

rm -f /tmp/_bg.svg /tmp/_bg.png /tmp/_large.png /tmp/_medium.png /tmp/_small.png
echo "Generated: icon16, icon32, icon48, icon96, icon128"
