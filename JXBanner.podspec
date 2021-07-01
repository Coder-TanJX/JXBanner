#
# Be sure to run `pod lib lint JXBanner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JXBanner'
  s.version          = '0.3.4'
  s.summary          = 'A multifunctional framework for banner unlimited rollover diagrams'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'The framework relies on JXPageConytrol and contains many custom interfaces, such as transition animation, view structure, and Settings'

  s.homepage         = 'https://github.com/Coder-TanJX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Code_TanJX' => 'code_tanjx@163.com' }
  s.source           = { :git => 'https://github.com/Coder-TanJX/JXBanner.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  
  s.ios.deployment_target = '8.0'
  
  
  if s.respond_to? 'swift_version'
      s.swift_version = "5.0"
  end
  
  if s.respond_to? 'swift_versions'
      s.swift_versions = ['4.2', '5.0']
  end
  
  s.subspec 'PageControl' do |ss|
      ss.source_files = 'JXBanner/Classes/PageControl/**/*'
      ss.dependency 'JXPageControl'
  end
  
  s.subspec 'Banner' do |ss|
      
      ss.subspec 'Cell' do |sss|
          sss.source_files = 'JXBanner/Classes/Banner/Cell/**/*'
      end
      
      ss.subspec 'Common' do |sss|
          sss.source_files = 'JXBanner/Classes/Banner/Common/**/*'
      end
      
      ss.subspec 'API' do |sss|
          sss.source_files = 'JXBanner/Classes/Banner/API/**/*'
          sss.dependency 'JXBanner/PageControl'
          sss.dependency 'JXBanner/Banner/Cell'
      end
      
      ss.subspec 'Transform' do |sss|
          sss.source_files = 'JXBanner/Classes/Banner/Transform/**/*'
          sss.dependency 'JXBanner/Banner/API'
      end
      
      ss.subspec 'Banner' do |sss|
          sss.source_files = 'JXBanner/Classes/Banner/Banner/**/*'
          sss.dependency 'JXBanner/Banner/API'
          sss.dependency 'JXBanner/Banner/Common'
          sss.dependency 'JXBanner/Banner/Transform'
      end
      
  end
  
end
