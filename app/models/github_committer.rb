class GithubCommitter
  def initialize repo: nil, note_name: '', note_contents: '', account: nil
    raise 'No repo supplied' if repo.nil?
    raise 'No account supplied' if account.nil?
    @account = account
    @repo = repo
    @note_name = note_name + '.html'
    @note_contents = note_contents
  end

  def commit!
    # repo, message, tree
    sha = nil
    begin
      file = @account.octokit_client.contents(
        @repo.name,
        path: @note_name
      )
      sha = file.sha
    rescue Octokit::NotFound
    end
    params = { branch: 'master' }
    params.merge! sha: sha if sha

    if @account.octokit_client.create_contents(
      @repo.name, #repo
      @note_name, #path
      'Ghenio update!', #commit message
      @note_contents, #file contents
      params
    )
      return true
    else
      raise 'Create commit failed!'
    end
  end
end
