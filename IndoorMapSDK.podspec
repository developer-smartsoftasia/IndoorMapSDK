Pod::Spec.new do |s|
  s.name         = 'IndoorMapSDK'
  s.version      = '1.0.0-beta-1'
  s.summary      = 'IndoorMapSDK'
  s.homepage     = 'https://github.com/developer-smartsoftasia/IndoorMapSDK.git'
  s.license      = 'Siam Piwat Company Limited'
  s.author       = 'Siam Piwat Company Limited'
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source       = { :git => 'https://github.com/developer-smartsoftasia/IndoorMapSDK.git', :tag => '#{s.version}' }
  s.ios.vendored_frameworks  = 'IndoorMap.framework'
  s.dependency 'RxSwift', '5.1.1'
  s.dependency 'RxCocoa', '5.1.1'
  s.dependency = 'RxDataSources', '4.0.1'
  s.dependency = 'RxGesture', '3.0.2'
  s.dependency = 'Action', '4.0.0'
  s.dependency = 'AlamofireImage', '~> 4.1'
  s.dependency = 'MBProgressHUD', '1.2.0'
  s.dependency = 'MappedIn', '1.11.0', :podspec => 'https://raw.githubusercontent.com/MappedIn/podspec/master/MappedIn/1.11.0/MappedIn.podspec'

end
