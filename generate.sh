#!/bin/bash
LOCALE=$1
BASENAME=gnomemm-website
HTMLDIR=html

# test whether $1 is empty
if [ -n "${LOCALE}" ]; then
	if [ -e "lang/${LOCALE}.po" ]; then
		echo "Generating html files for [${LOCALE}]"
		msgmerge -U lang/${LOCALE}.po lang/${BASENAME}.pot
		xml2po -p lang/${LOCALE}.po -o ${BASENAME}.${LOCALE}.xml ${BASENAME}.xml
		mkdir -p ${HTMLDIR}/${LOCALE}
		rm -rf ${HTMLDIR}/${LOCALE}/*.html
		xsltproc -o ${HTMLDIR}/${LOCALE}/ --xinclude param.xsl ${BASENAME}.${LOCALE}.xml
		rm ${BASENAME}.${LOCALE}.xml
		rm ${HTMLDIR}/${LOCALE}/root.html
	else
		echo "There is no translation for [${LOCALE}]."
	fi
else
	echo "Generating html files for [en]"
	mkdir -p ${HTMLDIR}/en
	rm -rf ${HTMLDIR}/en/*.html
	xsltproc -o ${HTMLDIR}/en/ --xinclude param.xsl ${BASENAME}.xml
	rm ${HTMLDIR}/en/root.html
fi

