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
	jhbuild dot meta-gnome-desktop > jhbuild_gnome_desktop.dot
	dot jhbuild_gnome_desktop.dot -Tpng > jhbuild_dot_gnome_desktop.png


#post-html: dependencies_gtkmm dependencies_gnomemm dependencies_gnome_desktop
post-html:
	rsync -avz --rsh ssh --cvs-exclude * $$USER@www.gtkmm.org:$(web_path)



