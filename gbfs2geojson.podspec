Pod::Spec.new do |s|
  s.name                  = 'gbfs2geojson'
  s.version               = '0.0.2'
  s.summary               = 'A number of functions to make using GBFS easier in your application orlibary'
  s.homepage              = 'https://github.com/motivateco/gbfs2geojson-obj-c'
  s.license               = 'Apache License, Version 2.0'
  s.author                = { 'Andrew Fischer' => 'afischer15@mac.com' }
  s.source                = { :git => 'https://github.com/motivateco/gbfs2geojson-obj-c.git', :tag => s.version.to_s}
  s.source_files          = 'gbfs2geojson/Classes/**/*'
  s.ios.deployment_target = '8.0'
  s.resource_bundles      = {'gbfs2geojson_Tests' => 'Example/**/*.json'}
end
