require File.expand_path("../lib/page_number", __FILE__)
require "date"

Gem::Specification.new do |s|
  s.name        = "page_number"
  s.version     = PageNumber::VERSION
  s.date        = Date.today
  s.summary     = "Utility methods for pagination page and per page that make sure you'll always have a valid number."
  s.description =<<-DESC
     Utility methods for pagination page and per page that make sure you'll always have a valid number.
     Use them your controllers or model or anywhere where you process page info.
  DESC
  s.authors     = ["Skye Shaw"]
  s.email       = "skye.shaw@gmail.com"
  s.extra_rdoc_files = %w[README.md]
  s.files       = Dir["lib/**/*.rb"]
  s.test_files  = Dir["test/**/*.rb"]
  s.homepage    = "https://github.com/sshaw/page_number"
  s.license     = "MIT"

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest", "~> 5.0"
end
