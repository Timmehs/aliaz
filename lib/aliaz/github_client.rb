require 'httparty'

module Aliaz
  class GithubClient
    include HTTParty
    base_uri 'https://api.github.com/'

    def initialize(github_token:)
      @access_token = github_token
      @headers = build_headers
    end

    def test
      self.class.get('/users/Timmehs/gists')
    end

    private

    def build_headers
      {
        Authorization: "token #{@access_token}"
      }
    end
  end
end
