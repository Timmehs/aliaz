require 'yaml/store'
require 'colorize'

module Aliaz
  class Config
    CONFIG_FILE = 'local_config'.freeze

    def initialize
      @config = YAML::Store.new(config_file_path)
    end

    def to_s
      puts "\nAliaz Configuration\n"
      @config.transaction(true) do
        @config.roots.each do |data_root_key|
          puts "#{data_root_key.to_s.ljust(15).colorize(:yellow)} #{@config[data_root_key]}"
        end
      end
    end

    def token
      get_key(:token)
    end

    def set_token(token)
      set_key(:token, token)
    end

    # If file not already listed && file exists, add to config
    def add_file(file_name)
      file_list = get_files

      if file_list.include? file_name
        puts 'File is already listed.'
      elsif File.file?(file_name)
        file_list << file_name
        set_key(:sync_files, file_list)
        puts "File added to syncable files list: '#{file_name}'"
      else
        puts 'File does not exist!'
      end
    end

    # If file is listed, remove from config
    def remove_file(file_name)
      file_list = get_files
      if file_list.include? file_name
        set_key(:sync_files, file_list - [file_name])
      else
        puts 'No such file listed'
      end
    end

    def get_files
      files = nil
      @config.transaction(true) { files = @config.fetch(:sync_files, []) }
      files
    end

    def get_key(key)
      value = nil
      @config.transaction(true) { value = @config[key] }
      value
    end

    private

    def set_key(key, value)
      @config.transaction do
        @config[key] = value
      end
    end

    def config_file_path
      File.join(Aliaz::ROOT, CONFIG_FILE)
    end
  end
end
