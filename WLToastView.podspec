#
# Be sure to run `pod lib lint WLToastView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WLToastView'
  s.version          = '0.0.3'
  s.summary          = '一款支持多种风格的指示器（HUD、Tips、Toast ... ）'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  一款支持多种风格的指示器（HUD、Tips、Toast ... ），支持多种动画
                       DESC

  s.homepage         = 'https://github.com/0624pdy/WLToastView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '0624pdy@sina.com' => 'pengduanyang@jze100.com' }
  s.source           = { :git => 'https://github.com/0624pdy/WLToastView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'WLToastView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WLToastView' => ['WLToastView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  
end
