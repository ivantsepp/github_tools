require 'octokit'
require 'thor'

require 'github_tools/version'
require 'github_tools/configuration'
require 'github_tools/cli'

module GithubTools
  extend self

  def client
    client = Octokit::Client.new(:access_token => Configuration.token)
  end
end
