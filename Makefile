PDFLATEX = pdflatex
LATEX = latex
WWW-BOOK = ~/Google\ Drive/algorithms-book

PREAMBLE = ./templates/preamble-diderot.tex
PANDOC = pandoc --mathjax -f latex

DC_HOME = ~/DC
#DC_HOME = ../main-s19/DC/bin

LABELTEX = $(DC_HOME)/texel
TEX2XML = $(DC_HOME)/dc -meta ./meta
TEX2XMLDBG = $(DC_HOME)/dc.dbg

default: pdf

FORCE: 

.PHONY: book html book-www book.pdf 


#	printf '%s\n' '\def\targethtml{}' >> book-html.tex
html: FORCE
	$(PANDOC) -s book-html.tex > book.html
#	rm book-html.tex

%_led.tex : %.tex FORCE
	$(LABELTEX) $<  -o $@

%.xml : %.tex FORCE
	$(TEX2XML) $< -preamble $(PREAMBLE) -o $@

%.xmldbg : %.tex
	$(TEX2XMLDBG) $< -preamble $(PREAMBLE) -o $@

clean: 
	rm \#* *~ *.aux *.idx *.log *.out *.toc */\#* */*~ */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 

all-xml: \
introduction/introduction.xml introduction/spec.xml genome/genome.xml \
######################################################################
## PDFs


book:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

pdf: book

book-www: book
	cp book.pdf $(WWW-BOOK)


exam:
	$(PDFLATEX) --jobname="exam" '\input{exam}' ; 
	$(PDFLATEX) --jobname="exam" '\input{exam}' ; \


## intro
intro: book introduction/introduction.tex

	$(PDFLATEX) --jobname="intro" '\includeonly{introduction/introduction}\input{book} '

## lambda
lambda: book lambda/lambda.tex 
	$(PDFLATEX) --jobname="lambda" '\includeonly{lambda/lambda} \input{book} '

