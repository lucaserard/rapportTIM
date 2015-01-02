all: rapport
rapport: rapport.pdf
	pdflatex rapport.tex
clean :
	rm -f *.pdf *.log *.aux
