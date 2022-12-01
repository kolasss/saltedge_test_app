module Connections
  class OauthCreate
    include Callable
    include Dry::Monads[:result, :do]

    def call(customer, provider_code)
      return Failure(:no_customer) unless customer

      provider = yield find_provider(provider_code)
      json = yield create_remote(customer, provider)
      connection = yield create(customer, json)

      Success(connection: connection, redirect_to: json.dig(:data, :redirect_url))
    end

    private

    def find_provider(provider_code)
      provider = Provider.find_by(code: provider_code)
      if provider
        Success(provider)
      else
        Failure(:provider_not_found)
      end
    end

    def create_remote(customer, provider)
      Saltedge.oauth_providers.create(
        customer_id: customer.saltedge_id,
        provider_code: provider.code
      )
    end

    def create(customer, json)
      connection = customer.connections.new(
        saltedge_id: json.dig(:data, :connection_id),
        data: json[:data]
      )
      if connection.save
        Success(connection)
      else
        Failure(connection.errors)
      end
    end
  end
end
