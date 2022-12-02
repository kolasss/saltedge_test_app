class Saltedge
  class << self
    include Dry::Monads[:result]

    APP_ID = ENV.fetch('SALTEDGE_APP_ID')
    SECRET = ENV.fetch('SALTEDGE_SECRET')
    API_URL = 'https://www.saltedge.com/api/v5/'.freeze

    def request(method, path, params = {})
      response = RestClient::Request.execute(
        method: method,
        url: API_URL + path,
        payload: params.to_json,
        # log: Logger.new($stdout),
        headers: headers
      )
      Success(json_parse(response.body))
    rescue RestClient::ExceptionWithResponse => e
      Failure(json_parse(e.response.body))
    end

    def customers
      Saltedge::Customers
    end

    def connections
      Saltedge::Connections
    end

    def accounts
      Saltedge::Accounts
    end

    def transactions
      Saltedge::Transactions
    end

    def oauth_providers
      Saltedge::OauthProviders
    end

    private

    def json_parse(string)
      JSON.parse(string, symbolize_names: true)
    end

    def headers
      {
        'Accept' => 'application/json',
        'Content-type' => 'application/json',
        'App-Id' => APP_ID,
        'Secret' => SECRET
      }
    end
  end
end
