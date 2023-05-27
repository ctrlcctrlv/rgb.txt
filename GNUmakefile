.PHOHY: all build_files build_patches clean

IN=runtime/rgb.txt
OUT=upstream/vim

all:
	$(MAKE) -j4 build_files build_patches README.md README.pdf

build_files:
	./build_files.sh $(IN) $(OUT)

build_patches:
	./build_patches.sh $(IN) $(OUT)

README.pdf: README.tex
	xelatex $< && \
		xelatex $< && \
		[ -f README.aux ] && \
		rm `basename $@ .pdf`.{aux,log,out}

README.md: README.tex
	pandoc -f latex -t gfm -i $< -o $@

clean:
	-rm rgb.*
	-rm dist/*
