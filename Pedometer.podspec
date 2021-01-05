

Pod::Spec.new do |s|


  s.name         = 'Pedometer'
  s.version      = '0.0.1'
  s.summary      = 'Use it to count your steps'
  s.homepage     = 'https://github.com/Huangshengquan/Pedometer.git'
  s.license      = 'MIT'
  s.authors      = { "黄盛全" => "1195759262@qq.com" }
  s.platform     = :ios, '11.0'#平台及支持的最低版本
  s.source       = { :git => 'https://github.com/Huangshengquaxn/Pedometer.git', :tag => s.version}
  s.source_files = 'Pedometer/**/*.{h,m}'
  s.requires_arc = true
  

end
