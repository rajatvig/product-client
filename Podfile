source 'https://github.com/CocoaPods/Specs.git'

def pods
  pod 'SwiftyJSON', '~> 2.3'
  pod 'Alamofire', '~> 3.4'
  pod 'SwiftDate', '~> 3.0'
end

def testing_pods
  pods

  pod 'Quick', '~> 0.9.2'
  pod 'Nimble', '~> 4.1.0'
end

target 'ProductClient' do
  use_frameworks!

  pods

  target 'ProductClientTests' do
    inherit! :search_paths

    testing_pods

    pod 'OHHTTPStubs', '~> 5.1.0'
    pod 'OHHTTPStubs/Swift', '~> 5.1.0'
  end

  target 'ProductClientContractTests' do
    inherit! :search_paths

    testing_pods

    pod 'PactConsumerSwift', '~> 0.2.1'
  end
end
