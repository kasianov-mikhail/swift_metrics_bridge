Pod::Spec.new do |s|
  s.name             = 'swift_metrics_bridge'
  s.version          = '0.1.0'
  s.summary          = 'Flutter bridge for Apple swift-metrics'
  s.description      = <<-DESC
Flutter plugin providing a Dart API for Apple's swift-metrics framework.
                       DESC
  s.homepage         = 'https://github.com/kasianov-mikhail/swift_metrics_bridge'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mikhail Kasianov' => '' }
  s.source           = { :path => '.' }
  s.source_files     = 'swift_metrics_bridge/Sources/swift_metrics_bridge/**/*'
  s.dependency 'Flutter'
  s.platform         = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.9'
end
