require 'httparty'

module Aliaz
  class GithubClient
    include HTTParty
    base_uri 'https://api.github.com/'

    def initialize(github_token)
      @config = Aliaz::Config.new
      @access_token = github_token
      @headers = build_headers
    end

    def user
      self.class.get('/user', @headers)
    end

    def gists
      login = @config.get_login
      if login.nil?
        puts 'Requires valid token'
        return
      end
      self.class.get("/users/#{login}/gists")
    end

    private

    def build_headers
      {
        headers: {
          "Authorization" => "token #{@access_token}",
          "User-Agent" => "Aliaz"
        }
      }
    end
  end
end
