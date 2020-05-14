Pod::Spec.new do |s|
  s.name             = 'ATKit_ObjectC'
  s.version          = '0.1.6'
  s.summary          = 'Some classes and class category commonly used in iOS rapid development'
  s.description      = <<-DESC
                       Some classes and class category commonly used in iOS rapid development.
                       DESC
  s.homepage         = 'http://blog.cocoachina.com/227971'
  s.license          = 'MIT'
  s.author           = { 'tianya2416' => '1203123826@qq.com' } 
  s.source           = { :git => 'https://github.com/tianya2416/ATKit_ObjectC.git', :tag => s.version }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'Source/*.{h,m}'
end


