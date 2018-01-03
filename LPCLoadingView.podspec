Pod::Spec.new do |s|

  s.name         = "LPCLoadingView"
  s.version      = "1.0.3"
  s.summary      = "LPCLoadingView library"
  s.description  = "LPCLoadingView is a library for loading of Le Pot Commun"
  s.homepage     = "https://github.com/LPC-Team/lpc-loading-view-ios"
  s.license      = "MIT"
  s.author             = { "Alaeddine Ouertani" => "ouertani.alaeddine@gmail.com" }
  s.source       = { :git => "https://github.com/LPC-Team/lpc-loading-view-ios.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "LPCLoadingView/**/*.Swift"
  s.exclude_files = "Classes/Exclude"
  s.platform = :ios, '9.0'

end
