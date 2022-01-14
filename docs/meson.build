# docs

# input: install_datadir, website_custom_cmd, python3
# output: can_parse_and_validate, build_translations_by_default, can_build_translations

# xsltproc is required by website_custom_cmd html.
xsltproc = find_program('xsltproc', required: true)

xmllint = find_program('xmllint', required: false)
can_parse_and_validate = xmllint.found()
validate = get_option('validation') ? 'true' : 'false'

can_build_translations = find_program('msgfmt', required: false).found() and \
                         find_program('itstool', required: false).found()
build_translations_by_default = get_option('build-translations')

xml_files = [
  'index.docbook', # Must be the first element in the list
  'books.xml',
  'bugs.xml',
  'commercial_support.xml',
  'developers.xml',
  'documentation.xml',
  'download.xml',
  'extra.xml',
  'git.xml',
  'license.xml',
  'mailinglist.xml',
  'main.xml',
  'news.xml',
]
xml_C_files = []
foreach f : xml_files
  xml_C_files += 'C' / f
endforeach

if can_build_translations and build_translations_by_default
  # Get a list of translated languages.
  language_obj = run_command(
    python3, website_custom_cmd, 'get_languages',
    meson.current_source_dir(),
  )
  if language_obj.stderr() != ''
    warning(language_obj.stderr())
  endif
  languages = language_obj.stdout().split()
else
  languages = []
endif

if can_parse_and_validate
  # Parse and possibly validate the C locale's version of the DocBook.
  custom_target('C-xmllint',
    input: xml_C_files,
    output: 'C_xmllint.stamp',
    command: [
      python3, website_custom_cmd, 'xmllint',
      validate,
      '@INPUT0@',
      '@OUTPUT@'
    ],
    build_by_default: true,
  )
endif

stylesheet_file = meson.current_source_dir() / 'param.xsl'

publishing_targets = []

# Create an html version of the C locale's version of the DocBook.
publishing_targets += custom_target('en_html_index.html',
  input: [stylesheet_file] + xml_C_files,
  output: 'en_html.stamp',
  command: [
    python3, website_custom_cmd, 'html',
    '@INPUT0@',
    '@INPUT1@',
    meson.current_build_dir() / 'html' / 'en',
    '@OUTPUT@',
  ],
  build_by_default: true,
  install: false,
)

# Install the C locale's XML files.
install_data(xml_C_files, install_dir: install_datadir / 'help' / 'C' / meson.project_name())

# gnome.yelp() is not used. It builds translations only at install time.
# This project is not necessarily installed before it's published at www.gtkmm.org.
# See https://github.com/mesonbuild/meson/issues/2775

foreach language : languages
  # Create translated XML files.
  tanslated_xml_target = custom_target(language + '_xml_index.docbook',
    input: [language / language + '.po'] + xml_C_files,
    output: language + '_xml.stamp',
    command: [
      python3, website_custom_cmd, 'translate_xml',
      '@INPUT0@',
      meson.current_source_dir() / 'C',
      meson.current_build_dir() / language, # Absolute path
      '@OUTPUT@',
      xml_files,
    ],
    build_by_default: true,
    install: false,
  )
  
  # Create an html version of the translated version of the DocBook.
  publishing_targets += custom_target(language + '_html_index.html',
    input: [stylesheet_file, tanslated_xml_target],
    output: language + '_html.stamp',
    command: [
      python3, website_custom_cmd, 'html',
      '@INPUT0@',
      meson.current_build_dir() / language / xml_files[0],
      meson.current_build_dir() / 'html' / language,
      '@OUTPUT@',
    ],
    build_by_default: true,
    install: false,
  )
  
  # Install the translated XML files.
  meson.add_install_script(
    python3, website_custom_cmd, 'install',
    meson.current_build_dir() / language,
    install_datadir / 'help' / language / meson.project_name(),
    xml_files,
  )
endforeach

# Publish the website at www.gtkmm.org.
run_target('publish',
  command: [
    python3, website_custom_cmd, 'publish',
  ],
  depends: publishing_targets,
)
