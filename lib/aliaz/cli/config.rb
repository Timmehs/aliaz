require 'thor'

module Aliaz
  module CLI
    class Config < Thor
      def initialize(*args)
        super
        @config = Aliaz::Config.new
      end

      default_task :list

      desc 'list', 'List configuration settings'
      def list
        @config.to_s
      end

      desc 'files', 'manage which files Aliaz should sync'
      method_option :add, aliases: '-a', desc: 'add a file for syncing'
      method_option :delete, aliases: '-d', desc: 'remove a file from sync list'
      def files
        if options[:add]
          @config.add_file(options[:add])
        elsif options[:delete]
          @config.remove_file(options[:delete])
          puts "Removed file from sync list: #{options[:delete]}"
        else
          puts 'ALIAZ SYNC LIST'
          @config.get_files.each { |f| puts "#{f}\n" }
        end
      end

      desc 'token <personal access token>', 'Set your Github personal access token.  Get one here: https://github.com/settings/tokens/new'
      def token(token)
        @config.set_token(token)
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
