
Pod::Spec.new do |spec|
spec.name         = "CiMA"
spec.version      = "1.0.0"
spec.summary      = "CiMA lets users build awesome apps with professional architecture in minutes."



# spec.homepage     = "https://www.my_homepage.com"

spec.license      = { :type => "MIT", :file => "LICENSE" }

# Replace with your name and e-mail address
spec.author = { "BABEL SI" => "cdm@babel.es" }

spec.documentation_url = "https://link_to_documentation.com"

spec.platforms = { :ios => "14.0", :osx => "10.15", :watchos => "6.0", :tvOS: "13.0" }

spec.swift_version = "5.5"

spec.source       = { :git => "https://link_to_my_repository.git", :tag => "#{spec.version}" }

spec.source_files  = "Sources/PackageName/**/*.swift"

spec.xcconfig = { "SWIFT_VERSION" => "5.5" }

end