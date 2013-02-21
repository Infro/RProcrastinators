output = .output
rnwfile = WriteUp
backup = .backup
BACKSLASH!=echo "\\"

all:
	R CMD Sweave $(rnwfile).Rnw
	-mkdir -p $(output)
	-cp format.tex.input format.tex
	-mv *.tex *.pdf *.eps $(output)
	cd $(output); R CMD texify --run-viewer --pdf $(rnwfile).tex 

tex:
	cd $(output); R CMD texify --run-viewer --pdf $(rnwfile).tex

clean:
	-rm $(output)/*

backup:
	-mkdir $(backup)
	cp	$(output)/$(rnwfile).pdf $(backup)/$(rnwfile).pdf