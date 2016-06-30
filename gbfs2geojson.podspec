#
# Be sure to run `pod lib lint gbfs2geojson.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'gbfs2geojson'
  s.version          = '0.0.1-beta'
  s.summary          = 'A parser for GBFS to convert it to geoJSON.'



  s.description      = <<-DESC
A number of functions to make using GBFS easier in your application or
libary.
                       DESC



  s.homepage         = 'https://github.com/motivateco/gbfs2geojson-obj-c'
  s.license          = { :type => 'CC-BY-2.0', :file => 'LICENSE' }
  s.author           = { 'Andrew Fischer' => 'afischer15@mac.com' }
  s.source           = { :git => 'https://github.com/motivateco/gbfs2geojson-obj-c.git', :tag => s.version.to_s}

  s.resource_bundles = {'gbfs2geojson_Tests' => 'Example/**/*.json'}

  s.ios.deployment_target = '8.0'

  s.source_files = 'gbfs2geojson/Classes/**/*'
end
