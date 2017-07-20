require 'thor'

module Aliaz
  module CLI
    class Config < Thor
      def initialize(*args)
        super
        @config = Aliaz::Config.new.config
      end

      desc 'list', 'List configuration settings'
      def list
        puts "#{'SETTING'.ljust(15)} VALUE"
        @config.transaction(true) do
          @config.roots.each do |data_root_key|
            puts "#{data_root_key.ljust(15)} #{@config[data_root_key]}"
          end
        end
      end

      desc 'token <personal access token>', 'Set your Github personal access token.  Get one here: https://github.com/settings/tokens/new'
      def token(token)
        return puts 'Invalid token length' unless token.length > 14
        @config.transaction do
          @config['github_token'] = token
          @config.commit
        end
        puts 'Aliaz Config: Github token set'
      end

      desc 'target <path to file>', 'path to the file you want to sync with Aliaz. (default: "~/.aliaz")'
      def target(file_path)
        @config.transaction do
          @config['target_file'] = file_path
          @config.commit
          puts 'Aliaz Config: Target set to ' + file_path
        end
      end
    end
  end
end
