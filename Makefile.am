ACLOCAL_AMFLAGS	= -I build ${ACLOCAL_FLAGS}
DISTCHECK_CONFIGURE_FLAGS = --enable-warnings=fatal

SUBDIRS = docs

dist_noinst_SCRIPTS = autogen.sh

# Distribute files needed when building with Meson.
EXTRA_DIST = \
  meson.build \
  meson_options.txt \
  docs/meson.build \
  docs/LINGUAS \
  tools/extra-dist-cmd.py \
  tools/website-custom-cmd.py
