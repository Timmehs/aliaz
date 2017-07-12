
module Aliaz
  module Config
    CONFIG_PATH = File.expand_path('config.yml', '../..')

    def initialize
      
    end

    def config_exists?; end

    def create_config; end

    def update_config(key, value); end
  end
end
