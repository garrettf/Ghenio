class WebhooksController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def evernote
    head :ok unless params[ :userId ]
    evernote_client = get_evernote_client params[:userId]

    if params[:reason] == "create" || params[:reason] == "update"
      note = get_note evernote_client, params[:guid], params[ :userId ]
      notebook = Notebook.find_by_evernote_guid(params[:notebookGuid])
      synchro = Synchronization.find_by_notebook_id(notebook.id)
      repo = synchro.repo

      committer = GithubCommitter.new(repo: repo,
                                      note_name: note.title,
                                      note_contents: note.content,
                                      account: synchro.account)
      committer.commit!
    end

    head :ok
  end

  def github
    head :ok unless params.key?( 'repository' )
    repo_str = params['repository']['full_name']
    repo = Repo.find_by_name(repo_str)
    synchro = repo.synchronization
    en_client = synchro.account.evernote_client
    en_user_id = en_client.user_store.getUser.id
    client = octokit_client_for_repo repo_str
    mod_arys = params['commits'].map do |com|
      com[ 'modified' ]
    end
    mod_arys.each do |modified|
      modified.each do |filename|
        file = client.content repo_str, path: filename
        text = Base64.decode64(file.content)
        note_name = filename.chomp( '.html' )
        committer = EvernoteCommitter.new( synchro.notebook.name )
        committer.update_note(
          note_name: note_name,
          note_contents: text,
          evernoteUserId: en_user_id
        )
      end
    end
    head :ok
  end

  private

  def access_token_string user_id
    EvernoteAccessToken.find_by_evernote_user_id(user_id).token
  end

  def octokit_client_for_repo repo_str
    Repo.find_by_name(repo_str).synchronization.account.octokit_client
  end

  def get_evernote_client(userId)
    @evernote_client ||= EvernoteClient.new(
      token: access_token_string(userId)
    )
  end

  def get_note(evernote_client, noteId, user_id)
    evernote_client.note_store.getNote( access_token_string( user_id ), noteId, true, false, false, false )
  end
end
