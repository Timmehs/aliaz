require 'thor'
require_relative './config'

module Aliaz
  class CLI < Thor
    include Aliaz::Config

    desc 'new <alias name> <command>', 'add an alias to your config'
    def new(alias_name, *command)
      return unless valid_alias?(alias_name)
      add_alias(alias_name, command)
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
      puts '=' * 60
      puts '| ' + 'Current Aliaz Configuration:'.ljust(57) + '|'
      puts '=' * 60
      current_config.each do |k, v|
        puts "| #{k.to_s.ljust(7)}| #{v.to_s.ljust(48)}|"
        puts '=' * 60
      end
    end

    private

    def add_alias(alias_name, command)
      # parsed_command = reconstruct_command(command)
      config_set(alias_name, command.join(' '))
    end

    def valid_alias?(cmd)
      if find_command(cmd)
        puts "AliazError: #{cmd} command already exists!"
        return false
      end
      true
    end

    def find_command(cmd)
      exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
      ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each do |ext|
          exe = File.join(path, "#{cmd}#{ext}")
          return exe if File.executable?(exe) && !File.directory?(exe)
        end
      end
      nil
    end
  end
end
