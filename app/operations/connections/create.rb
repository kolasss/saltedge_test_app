module Connections
  class Create
    include Callable
    include Dry::Monads[:result, :do]

    def call(customer, provider)
      json = yield create_remote(customer, provider)
      connection = yield create(customer, json)

      Success(connection)
    end

    private

    def create_remote(customer, provider)
      Saltedge.connections.create(
        customer_id: customer.saltedge_id,
        provider_code: provider.code
      )
    end

    def create(customer, json)
      connection = customer.connections.new(
        saltedge_id: json.dig(:data, :id),
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
