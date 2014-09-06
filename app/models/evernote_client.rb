class EvernoteClient
  def self.client opts = {}
    evernote_auth_defaults = {
      consumer_key: ENV.fetch( 'EVERNOTE_CONSUMER_KEY' ),
      consumer_secret: ENV.fetch( 'EVERNOTE_CONSUMER_SECRET' ),
      sandbox: ! Rails.env.production?
    }
    EvernoteOAuth::Client.new( opts.reverse_merge evernote_auth_defaults )
  end
end
