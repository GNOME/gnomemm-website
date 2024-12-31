# This file is part of gnomemm-website.

project('gnomemm-website',
  version: '2.91.4',
  meson_version: '>= 0.55.0', # required for meson.add_dist_script(python3, ...)
                              # and meson.add_install_script(python3, ...)
)

python3 = find_program('python3', version: '>=3.7')

# Installation directories are relative to {prefix}.
install_prefix = get_option('prefix')
install_datadir = get_option('datadir')

# Use these instead of meson.source_root() and meson.build_root() in subdirectories.
# source_root() and build_root() are not useful, if this is a subproject.
project_source_root = meson.current_source_dir()
project_build_root = meson.current_build_dir()

script_dir = project_source_root / 'tools'
website_custom_cmd = script_dir / 'website-custom-cmd.py'
extra_dist_cmd = script_dir / 'extra-dist-cmd.py'

# Copy some files to the build directory.
# (fs.copyfile() would be useful, if there were also a fs.copydir().)
copy_obj = run_command(
  python3, website_custom_cmd, 'copy_files_and_dirs',
  project_source_root / 'docs' / 'html',
  project_build_root / 'docs' / 'html',
  'index.html',
  'images',
  'style',
  check: false,
)
if copy_obj.stdout() != ''
  warning(copy_obj.stdout())
endif

# add_dist_script() is not allowed in a subproject if meson.version() < 0.58.0.
can_add_dist_script = not meson.is_subproject() or meson.version().version_compare('>= 0.58.0')

subdir('docs')

if can_add_dist_script
  # Don't distribute these files and directories.
  dont_distribute = [
    '.gitlab-ci.yml',
  ]
  # Modify the contents of the distribution directory.
  meson.add_dist_script(
    python3, extra_dist_cmd,
    project_source_root,
    project_build_root,
    dont_distribute,
  )
endif

# Print a summary.
validate = get_option('validation') and can_parse_and_validate
explain_val = ''
if get_option('validation') and not validate
  explain_val = ' (requires xmllint with Relax NG and DocBook V5.0 support)'
endif

summary = [
  '',
  '------',
  meson.project_name() + ' ' + meson.project_version(),
  '',
  '      XML validation: @0@@1@'.format(validate, explain_val),
  'Allow network access: @0@'.format(get_option('allow-network-access')),
  '  Build translations: @0@'.format(build_translations),
  'Directories:',
  '              prefix: @0@'.format(install_prefix),
  '             datadir: @0@'.format(install_prefix / install_datadir),
  '------'
]

message('\n'.join(summary))
