
Pod::Spec.new do |s|

  s.name         = "XHDatePicker"
  s.version      = "0.1.2"
  s.summary      = "日期选择器 for iOS."
  s.homepage     = "https://github.com/XHJCoder/XHDatePicker"
  s.license      = "MIT"
  s.author             = { "XH_J" => "1149949564@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/XHJCoder/XHDatePicker.git", :tag => "#{s.version}" }
  s.source_files  = "XHDatePicker","XHDatePicker/**/*.{h,m,xib}"
  s.framework  = "UIKit"

end
