module Customers
  class Create
    include Callable
    include Dry::Monads[:result, :do]

    def call(user)
      json = yield create_remote(user)
      create(user, json)
    end

    private

    def create_remote(user)
      Saltedge.customers.create(user.email)
    end

    def create(user, json)
      customer = user.build_customer(
        saltedge_id: json.dig(:data, :id),
        data: json[:data]
      )
      if customer.save
        Success(customer)
      else
        Failure(customer.errors)
      end
    end
  end
end
