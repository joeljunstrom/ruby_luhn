require 'rubygems'
require 'rake'
require 'rake/testtask'
require File.expand_path('../lib/luhn/version', __FILE__)

namespace :test do
  Rake::TestTask.new(:all) do |test|
    test.libs      << 'lib' << 'spec'
    test.pattern   = 'spec/**/spec_*.rb'
    test.verbose   = true
  end
end

task :test do
  Rake::Task['test:all'].invoke
end

task :default => :test
