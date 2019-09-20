Pod::Spec.new do |s|
  s.name             = 'AppBaseCategory'
  s.version          = '0.1.0'
  s.summary          = 'Some classes and class category commonly used in iOS rapid development'
  s.description      = <<-DESC
                       Some classes and class category commonly used in iOS rapid development.
                       DESC
  s.homepage         = 'http://blog.cocoachina.com/227971'
  s.license          = 'MIT'
  s.author           = { 'tianya2416' => '1203123826@qq.com' } 
  s.source           = { :git => 'https://github.com/tianya2416/AppBaseCategory.git', :tag => s.version }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'AppBaseCategory/*.{h,m}'
end

