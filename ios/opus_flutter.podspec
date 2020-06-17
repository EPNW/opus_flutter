#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opus_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'opus_flutter'
  s.version          = '0.0.1'
  s.summary          = 'libopus wrappers for flutter based on opus_dart'
  s.description      = <<-DESC
libopus wrappers for flutter based on opus_dart
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Eric Prokop und Nils Wieler Hard- und Softwareentwicklung GbR' => 'prokopwieler.hardundsoftware@gmail.com' }
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  
  s.source           = { :path => '.' }
  s.requires_arc = true
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.vendored_frameworks = "opus.framework"

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
