gnomemmwebsite_docdir = $(datadir)/doc/gnomemmwebsite-2.4

# Function: $(call vpath_listall,PATTERN ...)
# Get all filenames which match a PATTERN from the list.  Look for files
# relative to either the current directory or $(srcdir).  Strip $(srcdir)/
# again before returning and remove any duplicates.
vpath_srclist = $(patsubst $(srcdir)/%,%,$(wildcard $(addprefix $(srcdir)/,$(1))))
vpath_listall = $(sort $(wildcard $(1)) $(if $(srcdir:.=),$(vpath_srclist)))

XMLLINT = xmllint
XSLTPROC = xsltproc

@YELP_HELP_RULES@

HELP_ID = gnomemm-website
help_index_file = index.docbook
HELP_MEDIA =

# The names of any files included by xinclude (preferred):
HELP_FILES = \
        index.docbook \
        main.xml \
	books.xml \
	bugs.xml \
	commercial_support.xml \
	developers.xml \
	documentation.xml \
	download.xml \
	extra.xml \
	git.xml \
	license.xml \
	mailinglist.xml \
	news.xml


HELP_LINGUAS = cs de el es fr hu ko pt_BR sl sv zh_CN

MAINTAINERCLEANFILES =  $(foreach lang,en $(HELP_LINGUAS),html/$(lang)/*.html) \
			$(foreach lang,en $(HELP_LINGUAS),$(srcdir)/html/$(lang)/*.html)

tutorialdir         = $(gnomemmwebsite_docdir)/tutorial
tutorial_htmldir    = $(tutorialdir)/html
tutorial_figuresdir = $(tutorial_htmldir)/figures
tutorial_iconsdir   = $(tutorial_htmldir)/icons

tutorial_html_files = $(call vpath_listall,html/en/*.html) html/style/style.css
tutorial_html_inst  = $(foreach\
	file,$(tutorial_html_files),$(or $(wildcard $(file)),$(srcdir)/$(file)))

tutorial_xml_files  = $(addsuffix /index.docbook,C $(HELP_LINGUAS))
tutorial_po_files   = $(foreach lang, $(HELP_LINGUAS), $(lang)/$(lang).po)
website_indexes	    = $(foreach lang,$(HELP_LINGUAS),html/$(lang)/index.html)

dist_noinst_DATA =		\
	C/index.docbook	\
	$(tutorial_po_files)	\
	$(tutorial_xml_files)	\
	$(tutorial_html_files)

dist_tutorial_figures_DATA = $(addprefix C/,$(HELP_MEDIA))

dist_tutorial_icons_DATA =

$(HELP_LINGUAS): %: 
	@$(MKDIR_P) $@

all-local: $(HELP_LINGUAS) html/en/index.html $(website_indexes)

$(website_indexes): html/%/index.html:$(addprefix %/,$(HELP_FILES))
  lang=$(subst html/,,$(subst /index.html,,$@))
	$(AM_V_at)rm -rf html/$(lang)
	$(AM_V_at)$(MKDIR_P) html/$(lang)
	$(AM_V_GEN)$(XSLTPROC) -o html/$(lang)/ --xinclude $(srcdir)/param.xsl $(builddir)/$(lang)/$(help_index_file)
	$(AM_V_at)rm -f html/$(lang)/root.html

# Create a html generation of the C locale's version of the DocBook,
# using our custom stylesheet and graphics:
html/en/index.html: $(addprefix $(srcdir)/C/,$(HELP_FILES))
	$(AM_V_at)rm -fr html/en
	$(AM_V_at)$(MKDIR_P) html/en
	$(AM_V_GEN)$(XSLTPROC) -o html/en/ --xinclude $(srcdir)/param.xsl $(srcdir)/C/$(help_index_file)
	
validate: $(addprefix $(srcdir)/C/,$(HELP_FILES))
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




#Upload:

web_path = /home/murrayc/gtkmm.org/

#post-html: dependencies_gtkmm dependencies_gnomemm dependencies_gnome_desktop
post-html:
	rsync -avz --rsh ssh --cvs-exclude  html/.htaccess html/* $$USER@www.gtkmm.org:$(web_path)
