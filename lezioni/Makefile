NAME=lucidi_bioinformatica_stampa lucidi_bioinformatica_video
USE_PDFLATEX=1

TEXSRCS=lucidi_bioinformatica_testo.tex vc.tex


#sync:	vc.tex pdf
#	rsync -avz *.pdf Elearning Esami dellavedova@aspic.bio.disco.unimib.it:public_html/didattica/lab_statistico-informatico/

vc.tex:	../.git/logs/HEAD
	bash vc

include /usr/share/latex-mk/latex.gmk

