Gem::Specification.new do |s|
  s.name        = 'faker_spanish_documents'
  s.version     = '0.1.0'
  s.description = 'A simple faker to generate spanish documents as DNI, NIE or CIF'
  s.summary     = 'Generate valid DNI, NIE or CIF numbers'
  s.authors     = ['F. Padillo']
  s.email       = 'fpadillo@nosolosoftware.es'
  s.homepage    = 'https://github.com/nosolosoftware/faker_spanish'
  s.license     = 'MIT'
  s.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.add_dependency 'faker', '~> 2.18'
end
