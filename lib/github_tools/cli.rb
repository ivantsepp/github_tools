module GithubTools
  class CLI < Thor
    include Thor::Actions

    desc "open <pull_request_id>", "Opens the files for the corresponding pull request with your editor."
    long_desc <<-LONGDESC
     Open files with changes pertaining to a pull request. A side effect of this action is that 
     you will be in the latest SHA of that pull request.
    LONGDESC
    def open_pull_request(id)
      status = silent_run 'git status --porcelain 2>/dev/null'
      raise Thor::Error.new('You have uncommitted changes') unless status.empty?
      ENV['EDITOR'] = ask("Enter your text editor command:\n") if ENV['EDITOR'].nil?

      pull_files = GithubTools.client.pull_files(Configuration.remote, id)
      filenames = pull_files.collect(&:filename)
      silent_run "git fetch origin pull/#{id}/head:"
      run 'git checkout FETCH_HEAD', :verbose => false
      silent_run "#{ENV['EDITOR']} #{filenames.join(' ')}"
    end

    private

    def silent_run(cmd)
      run(cmd, :verbose => false, :capture => true)
    end
  end
end