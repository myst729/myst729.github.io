# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-theme-myst729'
  spec.version       = '0.1.0'
  spec.authors       = ['Leo']
  spec.email         = ['myst.dg@gmail.com']
  spec.homepage      = 'https://github.com/myst729/jekyll-theme-myst729'
  spec.summary       = 'Primer is a Jekyll theme for GitHub Pages based on GitHub’s Primer styles'

  spec.files         = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r{^(assets|_(includes|layouts|sass)/|(LICENSE|README)((\.(txt|md)|$)))}i)
  end

  spec.platform      = Gem::Platform::RUBY
  spec.license       = 'MIT'

  spec.add_dependency 'jekyll', '> 3.8'
  spec.add_runtime_dependency 'jekyll-github-metadata', '~> 2.12'
end
