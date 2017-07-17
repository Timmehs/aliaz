require 'httparty'

module Aliaz
  class GithubClient
    include HTTParty
    base_url 'https://api.github.com/gists'

    def initialize(:github_token, :github_user, :target_file)
      @access_token = access_token
      @headers = build_headers
      @file = target_file
    end

    def test; end

    private

    def build_headers
      {
        Authorization: "token #{@access_token}"
      }
    end
  end
end
