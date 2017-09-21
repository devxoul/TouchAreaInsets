Pod::Spec.new do |s|
  s.name             = 'TouchAreaInsets'
  s.version          = '1.0.0'
  s.summary          = 'Touch area insets for UIView'
  s.homepage         = 'https://github.com/devxoul/TouchAreaInsets'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Suyeol Jeon' => 'devxoul@gmail.com' }
  s.source           = { :git => 'https://github.com/devxoul/TouchAreaInsets.git',
                         :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.{h,m}'

  s.ios.deployment_target = '8.0'
end
