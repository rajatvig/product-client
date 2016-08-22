# coding: utf-8
Pod::Spec.new do |s|
  s.name         = "ProductClient"
  s.version      = "0.1.0"
  s.summary      = "ProductClient for Contract Test Demo"

  s.description  = <<-DESC
ProductClient to use the Product Service
                   DESC

  s.homepage     = "https://github.com/rajatvig/ProductClient"

  s.license      = "MIT"
  s.author             = { "Rajat Vig" => "rajatvig@gmail.com" }
  s.social_media_url   = "https://twitter.com/rajatvig"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/rajatvig/ProductClient.git", :tag => "#{s.version}" }

  s.source_files  = ["Sources/*.swift", "Sources/Models/*.swift"]

  s.dependency "Alamofire", "~> 3.4"
  s.dependency "SwiftyJSON", "~> 2.3"
  s.dependency 'SwiftDate', "~> 3.0"
end
