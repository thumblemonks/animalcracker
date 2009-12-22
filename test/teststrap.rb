require 'rubygems'

require 'riot'
require 'chicago/riot'
require 'mocha_standalone'

require 'animalcracker'

class Riot::Situation
  include Mocha::API
end

Riot::Context.class_eval do
  def mocha_support
    teardown { mocha_verify; mocha_teardown }
  end
end