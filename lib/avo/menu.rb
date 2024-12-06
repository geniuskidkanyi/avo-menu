require "zeitwerk"
require 'ostruct'

require "avo"
require "avo/menu/version"
require "avo/menu/engine" if defined?(Rails)

loader = Zeitwerk::Loader.for_gem_extension(Avo)
loader.setup

module Avo
  module Menu
    # Your code goes here...
  end
end

loader.eager_load
