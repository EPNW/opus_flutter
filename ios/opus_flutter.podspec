#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opus_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'opus_flutter'
  s.version          = '0.0.1'
  s.summary          = 'libopus wrappers for flutter based on opus_dart'
  s.description      = <<-DESC
  libopus wrappers for flutter based on opus_dart.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Eric Prokop und Nils Wieler Hard- und Softwareentwicklung GbR' => 'prokopwieler.hardundsoftware@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.vendored_frameworks = "opus.xcframework"
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
