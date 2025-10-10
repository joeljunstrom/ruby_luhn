# frozen_string_literal: true

require File.expand_path("../lib/luhn/version", __FILE__)

Gem::Specification.new do |s|
  s.name = "luhn"
  s.homepage = "http://github.com/joeljunstrom/ruby_luhn"
  s.summary = "A small implementation of the Luhn algorithm."
  s.require_path = "lib"
  s.authors = ["Joel Junström"]
  s.email = ["joel.junstrom@gmail.com"]
  s.version = Luhn::VERSION
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("{lib,spec}/**/*") + %w[LICENSE README.md]

  s.required_ruby_version = ">= 3.2"

  s.add_development_dependency "minitest", "~> 2.6.0"
end
