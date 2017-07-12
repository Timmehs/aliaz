require 'thor'
require_relative './config'

module Aliaz
  class CLI < Thor
    include Aliaz::Config

    desc 'new <alias name> <command>', 'add an alias to your config'
    def new(alias_name, command)
      config_set(alias_name, command)
      puts "#{alias_name} added."
    end

    desc 'remove <alias name>', 'remove an alias from your config'
    def remove(alias_name)
      deleted_command = config_delete(alias_name)
      if deleted_command.nil?
        puts "No such alias '#{alias_name}'"
      else
        puts "Alias #{alias_name} - #{deleted_command} removed."
      end
    end

    desc 'list', 'list current configuration'
    def list
      current_config = serialized_config

      puts "\n"
      puts ('=' * 60)
      puts "| " + 'Current Aliaz Configuration:'.ljust(57) + "|"
      puts ('=' * 60)
      current_config.each do |k, v|
        puts "| #{k.to_s.ljust(7)}| #{v.to_s.ljust(48)}|"
        puts ('=' * 60)
      end
    end
  end
end
