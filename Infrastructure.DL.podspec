#
# Be sure to run `pod lib lint Infrastructure.DL.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Infrastructure.DL'
  s.version          = '1.0.2'
  s.summary          = 'UnitOfWork and Repository pattern guidelines'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The repository and unit of work patterns are intended to create an abstraction layer between the data access layer and the business logic layer of an application. Implementing these patterns can help insulate our application from changes in the data store and can facilitate automated unit testing.
                       DESC

  s.homepage         = 'https://github.com/PisinO/Infrastructure.DL'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ondrej Pisin' => 'ondrej.pisin@gmail.com' }
  s.source           = { :git => 'https://github.com/PisinO/Infrastructure.DL.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/PisinO'

  s.ios.deployment_target = '12.0'
    s.swift_version = '5.1'
    
  s.source_files = 'Infrastructure.DL/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Infrastructure.DL' => ['Infrastructure.DL/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'NSPredicateObjectMapper'
end
