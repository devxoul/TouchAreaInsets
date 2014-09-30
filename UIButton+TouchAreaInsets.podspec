Pod::Spec.new do |s|
  s.name         = "UIButton+TouchAreaInsets"
  s.version      = "0.1.0"
  s.summary      = "Set UIButton's touch area insets."
  s.homepage     = "http://github.com/devxoul/UIButton-TouchAreaInsets"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "devxoul" => "devxoul@gmail.com" }
  s.source       = { :git => "https://github.com/devxoul/UIButton-TouchAreaInsets.git",
                     :tag => "#{s.version}" }
  s.platform     = :ios, '5.1'
  s.source_files = 'UIButton+TouchAreaInsets/*.{h,m}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
end
