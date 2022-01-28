# Gtkmm's website

This is the source of the [gtkmm website](https://www.gtkmm.org).

The source consists of a DocBook 5.0 document.
It requires the docbook5-xml and docbook-xsl-ns packages (Ubuntu names,
can have other names in other distros). It may be possible to build without
these packages, but it will be __much__ slower (minutes instead of seconds).[^1]

The website can be built with Meson or Autotools.

## Building with Meson

- Create a build directory and configure it:
  ```sh
  cd gnomemm-website
  meson [options] <build-dir>
  ```
  Do not call the build-dir gnomemm-website/build. There is already such a
  directory, used when building with Autotools.

- Create the html files of the website:
  ```sh
  cd <build-dir>
  ninja
  ```

- Watch the result:

  Open \<build-dir>/docs/html/index.html in a web browser.

- Publish the website at www.gtkmm.org (requires a login at www.gtkmm.org):
  ```sh
  ninja publish
  ```
  At the time of writing (2022-01-27) the `publish` target is disabled.
  You only get instructions how to enable it.

## Building with Autotools

- Configure, build in the source directory:
  ```sh
  cd gnomemm-website
  ./autogen.sh
  ```

- Create the html files of the website:
  ```sh
  make
  ```

- Watch the result:

  Open docs/html/index.html in a web browser.

- Publish the website at www.gtkmm.org (requires a login at www.gtkmm.org):
  ```sh
  cd docs
  make post-html
  ```

## Adding a new language

- Generate a temporary .pot file and the .po file for your locale, say xx_XX:
  ```sh
  cd docs
  itstool -o gnomemm-website.pot C/index.docbook C/*.xml
  mkdir xx_XX
  msginit -i gnomemm-website.pot -o xx_XX/xx_XX.po -l xx_XX.utf8
  ```

- Translate the .po file.

- Modify docs/C/index.docbook:

  Find `<formalpara xml:id="language-menu">`, and add your locale.
  ```xml
  <listitem>
    <para><link xlink:href="../xx_XX/index.html">Xxxx</link></para>
  </listitem>
  ```

- Add your language to docs/LINGUAS (used when building with Meson).

- Add your language to HELP_LINGUAS in docs/Makefile.am (used when building with Autotools).

- Run `make` or `ninja` to generate all pages.

--------------------
<!-- footnote -->
[^1]: The `xmllint` command is told to read files from `http://docbook.org`.
The `xsltproc` command is told to read files from `http://docbook.sourceforge.net`.
The commands first search for local copies of those files. If local copies exist
and are installed at expected locations, the commands make no network accesses.
