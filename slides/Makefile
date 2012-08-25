XSLT=saxon
RM=rm -f

#  one set of slides for each section?
#
TARGETS=example.html
TARGETS+=architecture.html

all:	$(TARGETS)

clean::;	$(RM) $(TARGETS)

.SUFFIXES: .xml .html

.xml.html:
	$(XSLT) $< styles/slides.xsl > $@
