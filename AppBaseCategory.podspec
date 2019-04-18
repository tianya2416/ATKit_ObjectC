Pod::Spec.new do |s|
  s.name             = 'AppBaseCategory'
  s.version          = '0.0.5'
  s.summary          = 'An one-line tool to show  styles of badge for UIView'
  s.description      = <<-DESC
                       An easy tool to show different styles of UIView objects without the need for subclassing.
                       DESC
  s.homepage         = 'http://blog.cocoachina.com/227971'
  s.license          = 'MIT'
  s.author           = { 'tianya2416' => '1203123826@qq.com' } 
  s.source           = { :git => 'https://github.com/tianya2416/AppBaseCategory.git', :tag => s.version }
  s.platform         = :ios, '8.0'
  s.requires_arc     = true
  s.source_files     = 'AppBaseCategory/*.{h,m}'
end

