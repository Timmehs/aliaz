require 'thor'
require 'colorize'
require_relative './config'

module Aliaz
  module CLI
    class Main < Thor
      def initialize(*args)
        super
        @config = Aliaz::Config.new
      end

      desc 'config', 'manage your Aliaz config'
      subcommand 'config', Config

      desc 'sync', 'sync aliases to Aliaz gist on Github'
      def sync
        puts 'hi'
      end

      desc 'gists', 'list the gists currently managed by Aliaz'
      def gists
        if @config.token
          client = Aliaz::GithubClient.new(github_token: @config.token)
          response = client.gists
          if response.success?
            gists = JSON.parse(response.body)
            puts "#{gists.size} gists found"
            gists.each do |g|
              puts g["description"]
            end
          else
            puts "Error: #{response.code} #{response.body}"
          end
        else
          puts 'You must set a token first, e.g.'.colorize(:red)
          puts "\taliaz config token <personal access token>"
        end
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
