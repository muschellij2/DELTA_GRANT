convert -density 300 DELTA.pdf -quality 100 img%02d.png

Rscript get_notes.R
Rscript create_auto_video.R
