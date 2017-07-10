require 'thor'

module Aliaz
  class CLI < Thor
    desc 'new ALIAS', 'add an alias to your config'
    def new(alias_name)
      puts alias_name
    end

    desc 'list', 'see aliases stored in aliaz'
    def list
      puts 'listing'
    end

    desc 'remove NAME', 'remove an alias by name'
    def remove(alias_name)
      puts 'removing ' + alias_name
    end

    desc 'set-token [TOKEN]', 'set your personal access token for syncing capability (get one here https://github.com/settings/tokens/new)'
    def set_token(token)
      puts "Setting #{token}"
    end
  end
end
