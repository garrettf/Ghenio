class WebhooksController < ApplicationController

  def evernote
    evernote_client = get_evernote_client params[:userId]

    if params[:reason] == "create" || params[:reason] == "update"
      note = get_note evernote_client, params[:guid]
      notebook = Notebook.find_by_evernote_guid(params[:notebookGuid])
      repo = Synchronization.find_by_notebook_id(notebook.evernote_guid).repo

      committer = GithubCommitter.new(repo , note.title, note.content, evernote_client.account)
      committer.commit!
    end

    head :ok
  end

  def get_evernote_client(userId)
    @evernote_client ||= EvernoteClient.new(
      token: EvernoteAccessToken.find_by_evernote_user_id(userId).token
    )
  end

  def get_note(evernote_client, noteId)
    evernote_client.note_store.getNote( evernote_client.token, noteId, true, false, false, false )
  end
end
