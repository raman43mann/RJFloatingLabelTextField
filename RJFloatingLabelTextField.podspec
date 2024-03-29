#
# Be sure to run `pod lib lint RJFloatingLabelTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name             = 'RJFloatingLabelTextField'
  s.version          = '0.1.1'
  s.summary          = 'RJFloatingLabelTextField is a simple library in iOS for Floating placeholder in TextField and TextView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: RJFloatingLabelTextField is a simple library in iOS for Floating placeholder in TextField and TextView
                       DESC

  s.homepage         = 'https://github.com/raman43mann/RJFloatingLabelTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'raman43mann' => 'rjmann43@gmail.com' }
  s.source           = { :git => 'https://github.com/raman43mann/RJFloatingLabelTextField.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.source_files = 'RJFloatingLabelTextField/Classes/**/*'
  
end
