

Pod::Spec.new do |spec|

  spec.name         = "Pedometer"
  spec.version      = "0.0.1"
  spec.summary      = "Use it to count your steps"


  spec.description  = "Use it to count your steps and have fun"

  spec.homepage     = "https://github.com/Huangshengquan/Pedometer.git"


  spec.license      = "MIT"

  spec.author             = { "黄盛全" => "1195759262@qq.com" }

  spec.source       = { :git => "https://github.com/Huangshengquaxn/Pedometer.git", :tag => "#{spec.version}" }
  #spec.source_files  = "Pedometer/*.{h,m}","Pedometer","Pedometer/class/**/*.{h,m}","Pedometer/**/*.{h,m}","Pedometer/class/**/**/*.{h,m}","Pedometer/**/*.h"
  spec.source_files  = "Pedometer/**/*"
  spec.exclude_files = "Pedometer/Info.plist"

  #spec.resources = "Pedometer/*.png"

  spec.static_framework = true
  
  spec.requires_arc = true # 是否启用ARC
  spec.platform     = :ios, "11.0" #平台及支持的最低版本
  spec.frameworks   = "UIKit", "Foundation" #支持的框架
  spec.library = 'sqlite3.0'
 
  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  

end
