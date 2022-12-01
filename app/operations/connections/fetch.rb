module Connections
  class Fetch
    include Callable
    include Dry::Monads[:result, :do]

    def call(connection)
      json = yield show_remote(connection)
      yield update(connection, json)
      yield fetch_accounts(connection)
      yield fetch_transactions(connection)

      Success(connection)
    end

    private

    def show_remote(connection)
      Saltedge.connections.show(connection.saltedge_id)
    end

    def update(connection, json)
      connection.data = json[:data]
      if connection.save
        Success(connection)
      else
        Failure(connection.errors)
      end
    end

    def fetch_accounts(connection)
      Accounts::FetchAll.call(connection)
    end

    def fetch_transactions(connection)
      connection.accounts.each do |account|
        yield Transactions::FetchAll.call(account)
      end

      Success()
    end
  end
end
