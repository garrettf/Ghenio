class WebhooksController < ApplicationController

  def evernote
    evernote_client = get_evernote_client params[:userId]

    if params[:reason] == "create" || params[:reason] == "update"
      note = get_note evernote_client, params[:guid], params[ :userId ]
      notebook = Notebook.find_by_evernote_guid(params[:notebookGuid])
      repo = Synchronization.find_by_notebook_id(notebook.evernote_guid).repo

      committer = GithubCommitter.new(repo , note.title, note.content, evernote_client.account)
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
      token: access_token_string(userID)
    )
  end

  def get_note(evernote_client, noteId, user_id)
    evernote_client.note_store.getNote( access_token_string( user_id ), noteId, true, false, false, false )
  end
end
