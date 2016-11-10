Pod::Spec.new do |s|

  s.name         = "PLTimelineView"
  s.version      = "0.0.1"
  s.summary      = "PLTimelineView is a customized timeline for iOS, simple and easy to use."
  s.homepage     = "https://github.com/PatrickSCLin/PLTimelineView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Patrick Lin" => "patricksclin@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/PatrickSCLin/PLTimelineView.git", :tag => "0.0.1" }
  s.source_files  = Dir['PLTimelineView/*']
  s.resources = "PLTimelineView/Resources/*.png"
  s.requires_arc = true
  
end
