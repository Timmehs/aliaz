require 'yaml/store'

module Aliaz
  module Config
    CONFIG_FILE = 'local_config.yml'.freeze

    def configuration
      @_configuration ||= YAML::Store.new(config_file_path)
    end

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
      File.join(Aliaz::ROOT, CONFIG_FILE)
    end

    def save_config(serialized_config)
      f = File.open(config_file_path, 'w')
      f.puts serialized_config.to_json
      f.close
    end

    def serialized_config
      raise 'No local config exists!' unless config_exists?
      YAML.load_file(config_file_path)
    end

    def initialize_config
      f = File.open(config_file_path, 'w')
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
