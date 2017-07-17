require 'thor'
require 'aliaz/version'
require 'aliaz/config'
require 'aliaz/cli'

module Aliaz
  CONFIG_FILE = 'local_config.json'.freeze
  ROOT = File.expand_path('../..', __FILE__)
end
