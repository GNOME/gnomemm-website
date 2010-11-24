gnomemmwebsite_docdir = $(datadir)/doc/gnomemmwebsite-2.4

# Function: $(call vpath_listall,PATTERN ...)
# Get all filenames which match a PATTERN from the list.  Look for files
# relative to either the current directory or $(srcdir).  Strip $(srcdir)/
# again before returning and remove any duplicates.
vpath_srclist = $(patsubst $(srcdir)/%,%,$(wildcard $(addprefix $(srcdir)/,$(1))))
vpath_listall = $(sort $(wildcard $(1)) $(if $(srcdir:.=),$(vpath_srclist)))

DOCBOOK_STYLESHEET_HTML ?= http://docbook.sourceforge.net/release/xsl/current/html/chunk.xsl
XMLLINT = xmllint
XSLTPROC = xsltproc

DOC_MODULE = gnomemm-website
DOC_ENTITIES =
DOC_INCLUDES =
DOC_FIGURES =

DOC_LINGUAS = zh_CN

MAINTAINERCLEANFILES = html/*.html $(srcdir)/html/*.html

# Set the use.id.as.filename param so that we don't use the chapter / section
# number as the filename, otherwise the url will change every time anything is
# re-ordered or inserted in the documentation
xslt_params = $(strip						\
	--param       toc.section.depth		1		\
	--stringparam html.stylesheet		'style.css'	\
	--stringparam admon.graphics		'1'		\
	--stringparam admon.graphics.path	'icons/'	\
	--stringparam admon.graphics.extension	'.png'		\
	--stringparam chunker.output.indent	'yes'		\
	--stringparam chunker.output.encoding	'UTF-8'		\
	--stringparam navig.graphics		'yes'		\
	--stringparam navig.graphics.extension	'.png'		\
	--stringparam navig.graphics.path	'icons/'	\
	--stringparam toc.list.type		'ul'		\
	--stringparam use.id.as.filename	'1'		\
	)

tutorialdir         = $(gnomemmwebsite_docdir)/tutorial
tutorial_htmldir    = $(tutorialdir)/html
tutorial_figuresdir = $(tutorial_htmldir)/figures
tutorial_iconsdir   = $(tutorial_htmldir)/icons

tutorial_html_files = $(call vpath_listall,html/*.html) style.css
tutorial_html_inst  = $(foreach\
	file,$(tutorial_html_files),$(or $(wildcard $(file)),$(srcdir)/$(file)))

tutorial_xml_files  = $(addsuffix /gnomemm-website.xml,C $(DOC_LINGUAS))
tutorial_po_files   = $(foreach lang,$(lang)/$(lang).po,$(DOC_LINGUAS))

dist_noinst_DATA =		\
	C/gnomemm-website.xml	\
	$(tutorial_po_files)	\
	$(tutorial_xml_files)	\
	$(tutorial_html_files)

dist_tutorial_figures_DATA = $(addprefix C/,$(DOC_FIGURES))

dist_tutorial_icons_DATA =

include $(top_srcdir)/build/gnome-doc-utils.make

all-local: $(DOC_LINGUAS) $(addsuffix /gnomemm-website.xml,C $(DOC_LINGUAS)) html/index.html

$(DOC_LINGUAS):
	@$(MKDIR_P) $@

# Create a html generation of the C locale's version of the DocBook,
# using our custom stylesheet and graphics:
html/index.html: $(srcdir)/C/gnomemm-website.xml
	$(AM_V_at)rm -fr html
	$(AM_V_at)$(MKDIR_P) html
	$(AM_V_GEN)$(XSLTPROC) $(xslt_params) -o html/ --xinclude --catalogs \
		'$(DOCBOOK_STYLESHEET_HTML)' $<

# Make sure that the documentation will always have been generated before
# executing the commands of a rule that depends on files in html/.
html/chapter-%.html html/sec-%.html: | html/index.html

validate: $(srcdir)/C/gnomemm-website.xml
	$(XMLLINT) --xinclude --postvalid --noout $<


.PHONY: install-tutorial uninstall-tutorial

# Instruct GNU make to delete the targets of a rule after it failed, in
# order to avoid the complication of handling that situation manually.
.DELETE_ON_ERROR:








#Use jhbuild to get a graphiv .dot file,
#and use the graphviz dot utility to make a .png of it:
dependencies_gtkmm:
	jhbuild dot gtkmm > jhbuild_gtkmm.dot
	dot jhbuild_gtkmm.dot -Tpng > jhbuild_dot_gtkmm.png

dependencies_gnomemm:
	jhbuild dot gnomemm/libgnomeuimm > jhbuild_gnomemm.dot
	dot jhbuild_gnomemm.dot -Tpng > jhbuild_dot_gnomemm.png

# This is not relevant to C++, but it is interesting.
dependencies_gnome_desktop:
	jhbuild dot meta-gnome-desktop > html/jhbuild_gnome_desktop.dot
	dot jhbuild_gnome_desktop.dot -Tpng > html/jhbuild_dot_gnome_desktop.png
