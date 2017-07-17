require 'thor'
require 'yaml/store'

module Aliaz
  class Config < Thor
    CONFIG_FILE = 'local_config.json'.freeze
    # TODO combine into one command with options
    desc 'list', 'List configuration settings'
    def list
      config = YAML.load_file(config_file_path).to_h
      puts "#{'SETTING'.ljust(15)} VALUE"
      config.each do |key, val|
        puts "#{key.ljust(15)} #{val}"
      end
    end

    desc 'token <personal access token>', 'Set your Github personal access token.  Get one here: https://github.com/settings/tokens/new'
    def token(token)
      return puts 'Invalid token length' unless token.length > 14
      configuration.transaction do
        configuration['github_token'] = token
      end
    end

    desc 'target <path to file>', 'path to the file you want to sync with Aliaz. (default: "~/.aliaz")'
    def target(file_path)
      configuration.transaction do
        configuration['target_file'] = file_path
      end
    end

    private

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
