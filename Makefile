web_path = /home/groups/g/gt/gtkmm/htdocs/

post-html: 
	scp $$SSH_OPT -r *.shtml fragments images $$USER@shell.sourceforge.net:$(web_path) 

