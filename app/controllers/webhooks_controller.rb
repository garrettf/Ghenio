class WebhooksController < ApplicationController

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

  private

  def access_token_string user_id
    EvernoteAccessToken.find_by_evernote_user_id(user_id).token
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
