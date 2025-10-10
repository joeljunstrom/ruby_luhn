# frozen_string_literal: true

$:.unshift File.expand_path(File.dirname(__FILE__) + "/../lib")
require "rubygems"
gem "minitest"
require "luhn"
require "minitest/benchmark" if ENV["BENCH"]
require "minitest/spec"
require "minitest/autorun"
