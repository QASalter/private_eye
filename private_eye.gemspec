# Run `rake private_eye.gemspec` to update the gemspec.
Gem::Specification.new do |s|
  # general infos
  s.name        = "private_eye"
  s.version     = "0.0.1"
  s.description = "No Description Yet"
  s.homepage    = "http://github.com/QASalter/private_eye"
  s.summary     = s.description

  # generated from git shortlog -sn
  s.authors = [
    "QASalter"
  ]

  # generated from git shortlog -sne
  s.email = [
    "s.salter@livelinktechnology.net"
  ]

  # generated from git ls-files
  s.files = [
    "License",
    "README.md",
    "Rakefile",
    "lib/private_eye.rb",
    "lib/private_eye/version.rb",
    "private_eye.gemspec",
    "spec/private_eye_spec.rb"
  ]

  # dependencies
  s.add_development_dependency "rspec", "~> 2.0"
end
