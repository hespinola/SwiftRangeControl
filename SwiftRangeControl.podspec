#
# Be sure to run `pod lib lint SwiftRangeControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftRangeControl'
  s.version          = '1.0.0'
  s.summary          = 'Range Slider Control based on UIControl'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/hespinola/SwiftRangeControl'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'GNU', :file => 'LICENSE' }
  s.author           = { 'Humberto Espinola' => 'h.espinola@inventivapp.com' }
  s.source           = { :git => 'https://github.com/hespinola/SwiftRangeControl.git', :tag => s.version }
  s.social_media_url = 'https://twitter.com/_hespinola'
  s.swift_version    = '4.2'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftRangeControl/**/*'
  
  # s.resource_bundles = {
  #   'SwiftRangeControl' => ['SwiftRangeControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'UIKit'
  s.module_name = 'SwiftRangeControl'
end
