# Run `rake private_eye.gemspec` to update the gemspec.
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'private_eye/version'

Gem::Specification.new do |s|
  # general infos
  s.name        = 'private_eye'
  s.version     = PrivateEye::VERSION
  s.description = 'Simple visual regression check for QATS'
  s.homepage    = 'http://github.com/QASalter/private_eye'
  s.summary     = s.description

  # generated from git shortlog -sn
  s.authors = [
    'QASalter'
  ]

  # generated from git shortlog -sne
  s.email = [
    's.salter@livelinktechnology.net'
  ]

  # generated from git ls-files
  s.files = [
    'License',
    'README.md',
    'Rakefile',
    'lib/private_eye.rb',
    'lib/private_eye/version.rb',
    'lib/private_eye/compare.rb',
    'private_eye.gemspec',
    'spec/private_eye_spec.rb'
  ]

  # dependencies
  s.add_development_dependency 'rspec', '~> 2.0'
  s.add_runtime_dependency 'parallel'
  s.add_runtime_dependency 'image_size'

end
