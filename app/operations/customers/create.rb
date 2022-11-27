module Customers
  class Create
    include Callable
    include Dry::Monads[:result, :do]

    def call(user)
      json = yield create_remote(user)
      # binding.pry
      create(user, json)
    end

    private

    def create_remote(user)
      # r = Saltedge::Customers.create(user.email)
      r = Saltedge.customers.create(user.email)
      # binding.pry
      r
      # if response.code == 200
      #   Success(JSON.parse(response.body))
      # else
      #   Failure(JSON.parse(response.body))
      # end
    end

    def create(user, json)
      customer = user.build_customer(
        saltedge_id: json.dig(:data, :id),
        data: json.dig(:data)
      )
      if customer.save
        Success(customer)
      else
        Failure(customer.errors)
      end
    end
  end
end
