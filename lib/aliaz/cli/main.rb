require 'thor'
require_relative './config'

module Aliaz
  module CLI
    class Main < Thor
      desc 'config', 'manage your Aliaz config'
      subcommand 'config', Config

      desc 'sync', 'sync aliases to Aliaz gist on Github'
      def sync
        puts 'hi'
      end

      desc 'test', 'test github client'
      def test
        puts 'o'
      end
      # desc 'list', 'list current configuration'
      # def list
      #   current_config = serialized_config
      #   puts "\n"
      #   puts '=' * 60
      #   puts '| ' + 'Current Aliaz Configuration:'.ljust(57) + '|'
      #   puts '=' * 60
      #   current_config.each do |k, v|
      #     puts "| #{k.to_s.ljust(7)}| #{v.to_s.ljust(48)}|"
      #     puts '=' * 60
      #   end
      # end
    end
  end
end
