name 'cobbler'
maintainer 'Bubba Nohead'
maintainer_email '<headless>@altiscale.com'
license 'All rights reserved'
description 'Installs/Configures cobbler'
long_description long_description IO.read(File.join(File.dirname(__FILE__),
                                                    'README.md'))
version IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

{
  'cobbler::default' => 'Installs/Configures cobbler'
}.each do |rec, desc|
  provides rec
  recipe rec, desc
end

JSON.parse(File.read(File.join(File.dirname(__FILE__), 'depends.json'))).each_pair do |cbk,ver|
  depends cbk,ver
end
