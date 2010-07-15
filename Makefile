BASENAME=gnomemm-website
SOURCE=$(BASENAME).xml
PARAM=param.xsl

all: en zh_CN

en: $(SOURCE) $(PARAM)
	bash generate.sh

l10n_base: pot $(PARAM)

zh_CN: l10n_base
	bash generate.sh zh_CN

pot: $(SOURCE)
	xml2po -o lang/$(BASENAME).pot $(BASENAME).xml

clean:
	rm -rf html/en/*.html html/zh_CN/*.html
	
	
#Upload:

web_path = /home/murrayc/gtkmm.org/
#web_path = /home/groups/g/gt/gtkmm/htdocs/

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


#post-html: dependencies_gtkmm dependencies_gnomemm dependencies_gnome_desktop
post-html:
	rsync -avz --rsh ssh --cvs-exclude  html/.htaccess html/* $$USER@www.gtkmm.org:$(web_path)




