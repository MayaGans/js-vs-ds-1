# Customization : set STEM to the root slug for the project.
STEM=jsvsds

# Tools.
JEKYLL=jekyll
LATEX=pdflatex
BIBTEX=bibtex
PANDOC=pandoc
PANDOC_FLAGS=--to=latex --listings

# Settings.
CHAPTERS_MD=$(filter-out _chapters_en/bib.md,$(wildcard _chapters_en/*.md))
CHAPTERS_TEX=$(patsubst _chapters_en/%.md,tex_en/inc/%.tex,${CHAPTERS_MD})

# Controls
.PHONY : commands serve site bib crossref clean
all : commands

## commands   : show all commands.
commands :
	@grep -h -E '^##' Makefile | sed -e 's/## //g'

## serve      : run a local server.
serve :
	${JEKYLL} serve -I

## site       : build files but do not run a server.
site :
	${JEKYLL} build

## pdf        : build PDF version of book.
pdf : tex_en/${STEM}.pdf

## tex        : generate LaTeX for book, but don't compile to PDF.
tex : ${CHAPTERS_TEX}

tex_en/${STEM}.pdf : ${CHAPTERS_TEX} tex_en/${STEM}.tex tex_en/${STEM}.bib
	@cd tex_en \
	&& ${LATEX} ${STEM} \
	&& ${BIBTEX} ${STEM} \
	&& ${LATEX} ${STEM} \
	&& ${LATEX} ${STEM} \
	&& ${LATEX} ${STEM}

tex_en/inc/%.tex : _chapters_en/%.md bin/texpre.py bin/texpost.py _includes/links.md
	mkdir -p tex_en/inc && \
	cat $< \
	| bin/texpre.py \
	| ${PANDOC} ${PANDOC_FLAGS} -o - \
	| bin/texpost.py _includes/links.md \
	> $@

tex_en/${STEM}.bib : files/${STEM}.bib
	cp $< $@

## bib        : rebuild Markdown bibliography from BibTeX source.
bib : _chapters_en/bib.md

_chapters_en/bib.md : files/${STEM}.bib bin/bib2md.py
	bin/bib2md.py en < $< > $@

## crossref   : rebuild cross-reference file.
crossref : files/crossref.js

files/crossref.js : bin/crossref.py _config.yml ${CHAPTERS_MD}
	bin/crossref.py _chapters_en < _config.yml > files/crossref.js

## ----------------------------------------

## spelling   : check spelling.
spelling :
	@grep bibnote files/${STEM}.bib \
	| cat - ${CHAPTERS_MD} \
	| aspell --mode=tex list \
	| sort \
	| uniq \
	| comm -2 -3 - words.txt

## words      : count words per chapter.
words :
	@wc -w ${CHAPTERS_MD} | sort -n -r

## nonascii   : look for non-ASCII characters.
nonascii :
	@bin/nonascii.py ${CHAPTERS_MD}

## clean      : clean up junk files.
clean :
	@rm -rf _site tex_en/${STEM}.bib tex_en/inc */*.aux */*.bbl */*.blg */*.log */*.out */*.toc
	@find . -name .DS_Store -exec rm {} \;
	@find . -name '*~' -exec rm {} \;

## settings   : show macro values.
settings :
	@echo 'JEKYLL = ' ${JEKYLL}
	@echo 'LATEX = ' ${LATEX}
	@echo 'BIBTEX = ' ${BIBTEX}
	@echo 'PANDOC = ' ${PANDOC}
	@echo 'PANDOC_FLAGS = ' ${PANDOC_FLAGS}
	@echo 'REPO = ' ${REPO}
	@echo 'CHAPTERS_MD = ' ${CHAPTERS_MD}
	@echo 'CHAPTERS_TEX = ' ${CHAPTERS_TEX}
