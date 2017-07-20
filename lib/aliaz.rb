require 'thor'
require 'aliaz/version'
require 'aliaz/config'
require 'aliaz/github_client'
require 'aliaz/cli/main'


module Aliaz
  CONFIG_FILE = 'local_config.json'.freeze
  ROOT = File.expand_path('../..', __FILE__)
end
