#
# Be sure to run `pod lib lint gbfs2geojson.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'gbfs2geojson'
  s.version          = '0.0.1'
  s.summary          = 'A parser for GBFS to convert it to geoJSON.'


# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC



  s.homepage         = 'https://github.com/motivateco/gbfs2geojson-obj-c'
  s.license          = { :type => 'CC-BY-3.0', :file => 'LICENSE' }
  s.author           = { 'Andrew Fischer' => 'afischer15@mac.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/test.git', :tag => s.version.to_s }

  s.resource_bundles = {'gbfs2geojson_Tests' => 'Example/**/*.json'}

  s.ios.deployment_target = '8.0'

  s.source_files = 'gbfs2geojson/Classes/**/*'
end
