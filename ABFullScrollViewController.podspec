Pod::Spec.new do |s|
 
  s.name         = "ABMFullScrollBehavior"
  s.version      = "2.0"
  s.summary      = "Component that provide the behavior of hidding a header view while the user makes scroll. It is inspiring in Facebook table scroll style."
  s.homepage     = "https://github.com/andresbrun/ABFullScrollViewController"
  s.screenshots  = "https://raw.githubusercontent.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/ABFullScrollVC_screen_1.png"
 
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Andrés Brun Moreno" => "andresbrunmoreno@gmail.com" }
 
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/andresbrun/ABFullScrollViewController.git", :tag => "CocoaPods/v2.0" }
 
  s.source_files  = 'ABMFullScrollBehavior/*.{h,m}'
 
  s.requires_arc = true
 
end
