#http://stackoverflow.com/questions/10943695/what-is-the-knitr-equivalent-of-r-cmd-sweave-myfile-rnw
#http://www.ibspan.waw.pl/~gagolews/?page=resources&subpage=tips


output = .output
rnwfile := $(wildcard *.knitr.rnw)
texfile := $(rnwfile:.rnw=.tex)
backup = .backup
BACKSLASH!=echo "\\"

all:
	Rscript -e "library(knitr); knit2pdf('$(rnwfile)')"
#	-mkdir -p $(output)
#	-cp format.tex.input format.tex
#	-mv *.tex *.pdf *.eps $(output)
#	-cp *.bib $(output)
#	cd $(output); R CMD texify --run-viewer --pdf $(texfile)

tex:
	cd $(output); R CMD texify --run-viewer --pdf $(texfile)

clean:
	-rm $(output)/*

backup:
	-mkdir $(backup)
	cp	$(output)/$(rnwfile).pdf $(backup)/$(rnwfile).pdf