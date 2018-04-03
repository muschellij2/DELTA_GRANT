
all: DELTA.pdf img*.png joey.mp4 kim.mp4

DELTA.pdf: DELTA.pptx
	soffice --convert-to pdf --headless DELTA.pptx

img*.png: DELTA.pdf
	convert -density 300 DELTA.pdf -quality 100 img%02d.png

script.txt: DELTA.pptx
	Rscript get_notes.R

*.mp4: script.txt
	Rscript render_video.R
