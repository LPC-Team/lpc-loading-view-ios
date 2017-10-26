Pod::Spec.new do |s|

  s.name         = "LPCLoadingView"
  s.version      = "1.0.0"
  s.summary      = "LPCLoadingView is a library for loading of Le Pot Commun"
  s.description  = "LPCLoadingView is a library for loading of Le Pot Commun"
  s.homepage     = "https://github.com/LPC-Team/lpc-loading-view-ios"
  s.screenshots  = "https://github.com/LPC-Team/lpc-loading-view-ios/blob/master/LPC_Loading_View_Demo.jpg"
  s.license      = "MIT"
  s.author             = { "Alaeddine Ouertani" => "ouertani.alaeddine@gmail.com" }
  s.source       = { :git => "https://github.com/LPC-Team/lpc-loading-view-ios.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
