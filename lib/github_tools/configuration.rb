module GithubTools
  module Configuration
    extend self

    def token
      token = `git config githubtools.token`.strip
      token = create_token if token.empty?
      token
    end

    def create_token
      print 'Username:'
      username = gets.strip
      print 'Password (never saved):'
      password = STDIN.noecho(&:gets).strip
      client = Octokit::Client.new(:login => username, :password => password)
      response = client.create_authorization(
        :scopes => [:repo],
        :note => 'github_tools',
        :note_url =>'https://github.com/ivantsepp/github_tools')
      token = response[:token]
      save_token(token)
      token
    end

    def save_token(token)
      `git config --global githubtools.token #{token}`
    end

    def remote
      url = `git config --get remote.origin.url`.strip
      url = 'ssh://' + url if url.include?('@')
      url.gsub!('.git', '')
      Octokit::Repository.from_url(url)
    end

  end
end
