#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opus_flutter_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'opus_flutter_ios'
  s.version          = '0.0.3'
  s.summary          = 'libopus wrappers for flutter in iOS.'
  s.description      = <<-DESC
  libopus wrappers for flutter in iOS.
                       DESC
  s.homepage         = 'https://epnw.eu'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'EPNW GmbH' => 'contact@epnw.eu' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.vendored_frameworks = 'opus.xcframework'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'OTHER_LDFLAGS' => '-all_load'  }
  s.swift_version = '5.1'
end
