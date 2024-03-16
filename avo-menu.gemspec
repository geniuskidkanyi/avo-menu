require_relative 'lib/avo/menu/version'
require_relative '../avo/lib/avo/version'

Gem::Specification.new do |spec|
  spec.name        = 'avo-menu'
  spec.version     = Avo::Menu::VERSION
  spec.authors     = ['Adrian']
  spec.email       = ['adrian@adrianthedev.com']
  spec.homepage    = 'https://avohq.io'
  spec.summary     = 'Menu builder feature for Avo.'
  spec.description = 'Menu builder feature for Avo.'
  spec.license     = 'Commercial'

  spec.metadata['allowed_push_host'] = 'https://rubygems.pkg.github.com/avo-hq'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/avo-hq/avo-menu'
  spec.metadata['changelog_uri'] = spec.homepage

  spec.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md', 'avo-menu.gemspec']

  spec.add_dependency 'avo', '>= 3.5.1'
  spec.add_dependency 'docile'
  spec.add_dependency 'dry-initializer'
  spec.add_dependency 'zeitwerk', '>= 2.6.12'
end
