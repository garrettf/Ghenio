class WebhooksController < ApplicationController

  def evernote
    evernote_client = get_evernote_client params[:userId]

    if params[:reason] == "create" || params[:reason] == "update"
      note = get_note evernote_client, params[:guid]
      commit_to_github note.title, note.content
    end

    head :ok
  end

  def get_evernote_client(userId)
    EvernoteAccessToken.find_by_evernote_user_id(userId)
  end

  def get_note(evernote_client, noteId)
    evernote_client.note_store.getNote( evernote_client.token, noteId, true, false, false, false )
  end
end
