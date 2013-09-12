NAME=lucidi_bioinformatica_stampa lucidi_bioinformatica_video
USE_PDFLATEX=1

TEXSRCS=lucidi_bioinformatica_testo.tex vc.tex

#sync:	vc.tex pdf
#	rsync -avz *.pdf Elearning Esami dellavedova@aspic.bio.disco.unimib.it:public_html/didattica/lab_statistico-informatico/

vc.tex:	../.git/logs/HEAD
	./vc


# Below are the code snippets
OTHER+=	code/sais/sais.h
code/sais/sais.h:	../sais/sais.h
	./cut_lines.sh $< $(@D)

OTHER+=	code/sais/sais.c
code/sais/sais.c:	../sais/sais.c
	./cut_lines.sh $< $(@D)


include latex.gmk
