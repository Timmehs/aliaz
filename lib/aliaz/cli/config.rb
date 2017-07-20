require 'thor'

module Aliaz
  module CLI
    class Config < Thor
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
    end
  end
end
