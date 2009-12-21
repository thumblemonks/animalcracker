ENV["RACK_ENV"] = "test"

$:.concat(["..", "../lib"])
require 'rubygems'
require 'caress'

require 'riot'
require 'chicago/riot'
require 'rack/test'
require 'mocha_standalone'

class Riot::Situation
  include Mocha::API
end

Riot::Context.class_eval do
  def mocha_support
    teardown { mocha_verify; mocha_teardown }
  end
end