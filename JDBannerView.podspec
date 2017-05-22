Pod::Spec.new do |s|

  s.name         = "JDBannerView"
  s.version      = "0.0.1"
  s.summary      = "JDBannerView is a commonly used banner."
  s.description  = %{A custom bannerView which can load webImage and localImage.}

  s.homepage     = "https://github.com/qigeligedongdongqiang/BannerView"
  s.license      = "MIT"
  s.author       = { "Ngmm_Jadon" => "maojiadong@ngmm365.com" }
  s.source       = { :git => "https://github.com/qigeligedongdongqiang/BannerView.git", :tag => "0.0.1" }
  s.source_files  = "JDBannerView", "*.{h,m}"  
  
  s.platform     = :ios
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.dependency "SDWebImage"

end
