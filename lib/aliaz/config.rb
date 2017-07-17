require 'json'

module Aliaz
  module Config
    CONFIG_FILE = 'local_config'.freeze
    ROOT = File.expand_path('../../..', __FILE__)

    def config_set(key, value)
      current_config = find_or_create_config
      save_config(current_config.merge(key => value))
    end

    def config_delete(alias_name)
      current_config = find_or_create_config
      deleted_command = current_config.delete(alias_name)
      save_config(current_config)
      deleted_command
    end

    def config_file_path
      File.join(ROOT, CONFIG_FILE)
    end

    def config
      JSON.parse(config_file_path)
    end

    def save_config(serialized_config)
      f = File.open(config_file_path, 'w')
      f.puts serialized_config.to_json
      f.close
    end

    def serialized_config
      raise 'No local config exists!' unless config_exists?
      JSON.parse(File.read(config_file_path))
    end

    def initialize_config
      f = File.open(config_file_path, 'w')
      f.puts '{}'
      f.close
    end

    def find_or_create_config
      initialize_config unless config_exists?
      serialized_config
    end

    def config_exists?
      File.exist?(config_file_path)
    end
  end
end
