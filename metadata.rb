name             'alti_skeleton'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures alti_skeleton'
long_description long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

{
  'alti_skeleton::default' => 'Installs/Configures alti_skeleton'
}.each do |rec, desc|
  provides rec
  recipe rec, desc
end
