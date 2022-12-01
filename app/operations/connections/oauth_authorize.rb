module Connections
  class OauthAuthorize
    include Callable
    include Dry::Monads[:result, :do]

    def call(user, params)
      token = yield extract_token(params)
      connection = yield find_connection(user, token)
      json = yield authorize_remote(connection, params)
      update(connection, json)

      Success(connection)
    end

    private

    def extract_token(params)
      match = params[:state]&.match(/connect_token_(\w+)/)
      return Failure(:no_token) unless match

      Success(match[1])
    end

    def find_connection(user, token)
      connection = user.connections.find_by("connections.data ->> 'token' = ?", token)
      return Failure(:no_connection) unless connection

      Success(connection)
    end

    def authorize_remote(connection, params)
      Saltedge.oauth_providers.authorize(
        connection.saltedge_id,
        params.permit!.to_query
      )
    end

    def update(connection, json)
      connection.data = json[:data]

      if connection.save
        Success(connection)
      else
        Failure(connection.errors)
      end
    end
  end
end
