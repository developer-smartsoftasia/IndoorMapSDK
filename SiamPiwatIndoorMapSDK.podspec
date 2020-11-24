Pod::Spec.new do |s|
  s.name         = "SiamPiwatIndoorMapSDK"
  s.version      = "0.9.0"
  s.summary      = "SiamPiwatIndoorMapSDK"
  s.homepage     = "https://github.com/developer-smartsoftasia/IndoorMapSDK.git"
  s.license      = "Siam Piwat Company Limited"
  s.author       = "Siam Piwat Company Limited"
  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"
  s.swift_version = "5.3"
  s.source       = { :git => "https://github.com/developer-smartsoftasia/IndoorMapSDK.git", :tag => "#{s.version}" }
  s.vendored_frameworks = "IndoorMap.framework", "Mappedin.xcframework"
  s.requires_arc = true
  s.dependency "RxSwift", "5.1.1"
  s.dependency "RxCocoa", "5.1.1"
  s.dependency "RxGesture", "3.0.2"
  s.dependency "Action", "4.1.0"
  s.dependency "Device", "3.2.1"
  s.dependency "Toast-Swift", "5.0.1"
  s.dependency "Kingfisher", "5.15.1"
  s.user_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.pod_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
