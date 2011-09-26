# encoding: UTF-8
require File.expand_path('../lib/luhn/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'ruby_luhn'
  s.homepage     = 'http://github.com/joeljunstrom/ruby-luhn'
  s.summary      = 'Thin layer over the ruby driver that allows you to quickly grab hold of your data (pluck it!).'
  s.require_path = 'lib'
  s.authors      = ['Joel Junström']
  s.email        = ['joel.junstrom@gmail.com']
  s.version      = Luhn::Version
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir.glob("{lib,spec}/**/*") + %w[LICENSE README]

  s.add_development_dependency 'minitest', '~> 2.6.0'
end