CP=lib/calabash.jar:lib/commons-httpclient-3.1.jar:lib/commons-io-1.3.1.jar:lib/commons-logging-1.1.1.jar:lib/jython.jar:lib/dbpygments.jar:lib/saxon9he.jar:lib/xmlresolver.jar:lib
RM=rm -f
VPATH=src

#TARGETS=example.html
TARGETS=session1.html
TARGETS+=architecture.html
TARGETS+=session3.html
TARGETS+=session4.html
TARGETS+=html.html
TARGETS+=css.html
TARGETS+=javascript.html
TARGETS+=security_authentication.html

PYTHONPATH := lib/python2.6/site-packages/Pygments-1.5-py2.6.egg:lib/jython-2.5.2/Lib:__classpath__:__pyclasspath__/

all: $(TARGETS)

clean::
	$(RM) $(TARGETS)

architecture.html: src/architecture.xml style/slides.xsl
	@echo Building $@
	@java -cp $(CP) \
             -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl \
             net.sf.saxon.Transform -s:$< -xsl:style/slides.xsl -o:$@

.SUFFIXES: .xml .html

.xml.html: style/dbslides.xsl
	@echo Building $@
	@java -cp $(CP) \
             -Dpython.path=$(PYTHONPATH) \
             -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl \
             com.xmlcalabash.drivers.Main -isource=$< -oresult=$@ style/dbslides.xpl
