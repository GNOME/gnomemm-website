web_path = /home/groups/g/gt/gtkmm/htdocs/

#Use jhbuild to get a graphiv .dot file,
#and use the graphviz dot utility to make a .png of it:
dependencies_gtkmm:
	jhbuild dot gtkmm2 > jhbuild_gtkmm.dot
	dot jhbuild_gtkmm.dot -Tpng > jhbuild_dot_gtkmm.png

dependencies_gnomemm:
	jhbuild dot gnomemm/libgnomeuimm > jhbuild_gnomemm.dot
	dot jhbuild_gnomemm.dot -Tpng > jhbuild_dot_gnomemm.png


post-html: dependencies_gtkmm dependencies_gnomemm
	rsync -avz --rsh ssh --cvs-exclude * $$USER@shell.sourceforge.net:$(web_path)



