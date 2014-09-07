# TODO: Gemfile this
require 'open-uri'
class GithubTokenRetriever
  GITHUB_CALLBACK_URL = ENV.fetch('BASE_URI') + '/callbacks/github'
  def self.retrieve opts = {}
    slug = 'https://github.com'
    params = {
      client_id: ENV.fetch('GITHUB_CLIENT_ID'),
      client_secret: ENV.fetch('GITHUB_CLIENT_SECRET'),
      code: opts[ :code ],
      redirect_uri: GITHUB_CALLBACK_URL
    }
    uri = URI.parse slug
    client = Net::HTTP.new(uri.host, uri.port)
    client.use_ssl = true
    client.start do |http|
      post_data = URI.encode_www_form( params )
      response = http.post('/login/oauth/access_token', post_data)
      token = CGI.parse response.body
      raise 'Github Authentication Error' if token[ 'error' ].present?
      if GithubAccessToken.create(
        token: token[ 'access_token' ].first,
        account: Account.find(opts[ :account_id ])
      )
        return true
      else
        return false
      end
    end
  end
end
