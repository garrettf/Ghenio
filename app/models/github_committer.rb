class GithubCommitter
  def initialize repo: nil, note_name: '', note_contents: '', account: nil
    raise 'No repo supplied' if repo.nil?
    raise 'No account supplied' if account.nil?
    @account = account
    @repo = repo
    @note_name = note_name
    @note_contents = note_contents
  end

  def commit!
    # repo, message, tree
    if @account.octokit_client.create_contents(
      @repo.name, #repo
      @note_name, #path
      'Ghenio update!', #commit message
      @note_contents, #file contents
      branch: 'master'
    )
      return true
    else
      raise 'Create commit failed!'
    end
  end
end
