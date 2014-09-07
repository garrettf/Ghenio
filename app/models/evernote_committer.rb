class EvernoteCommitter
  def initialize notebook_name: ''
    @notebook_name = notebook_name
  end

  def update_note note_name: '', note_contents: '', evernoteUserId: nil
    evernote_client = get_evernote_client evernoteUserId
    notebooks = evernote_client.note_store.listNotebooks
    notebook = notebooks.detect { |nb| nb.name == @notebook_name }
    notes = evernote_client.note_store.findNotes(access_token_string(evernoteUserId), { :notebookGuid => notebook.guid }, 0, 10000)
    note = notes.detect { |note| note.name == note_name}
    note.content = note_contents
    evernote_client.note_store.updateNote(access_token_string(evernoteUserId), note)
  end

  def access_token_string user_id
    EvernoteAccessToken.find_by_evernote_user_id(user_id).token
  end

  def get_evernote_client userId
    @evernote_client ||= EvernoteClient.new(
        token: access_token_string(userId)
    )
  end

  def get_note(evernote_client, noteId, user_id)
    evernote_client.note_store.getNote( access_token_string( user_id ), noteId, true, false, false, false )
  end
end
