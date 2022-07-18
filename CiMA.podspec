
Pod::Spec.new do |spec|
spec.name         = "CiMA"
spec.version      = "1.0.0"
spec.summary      = "CiMA lets users build awesome apps with professional architecture in minutes."



spec.homepage     = "https://github.com/babel-cdm/CiMA"

spec.license      = { :type => "MIT", :file => "LICENSE" }

spec.author = { "BABEL SI" => "cdm.babel@gmail.com" }

spec.documentation_url = "https://github.com/babel-cdm/CiMA/wiki"

spec.platforms = { :ios => "14.0", :osx => "10.15", :watchos => "6.0", :tvOS: "13.0" }

spec.swift_version = "5.5"

spec.source = { :git => "https://github.com/babel-cdm/CiMA.git", :tag => "#{spec.version}" }

spec.source_files  = "Sources/**/*.swift"

spec.xcconfig = { "SWIFT_VERSION" => "5.5" }

end