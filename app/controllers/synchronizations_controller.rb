class SynchronizationsController < ApplicationController
  before_filter :authenticate

  def create
    repo = Repo.create! name: params[ :repo_name ]
    current_account.evernote_client
    guid = current_account.evernote_client.note_store.listNotebooks.detect do |nb|
      nb.name == 'First Notebook'
    end.guid
    notebook = Notebook.create! name: params[ :notebook_name ], evernote_guid: guid
    Synchronization.create! repo: repo, notebook: notebook, account: current_account
    redirect_to '/'
  end
end
