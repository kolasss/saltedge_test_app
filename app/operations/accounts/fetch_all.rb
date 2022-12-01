module Accounts
  class FetchAll
    include Callable
    include Dry::Monads[:result, :do]

    def call(connection)
      json = yield list_remote(connection)
      process_data(connection, json[:data])
    end

    private

    def list_remote(connection)
      Saltedge.accounts.list(connection.saltedge_id)
    end

    def process_data(connection, json_data)
      return Failure(:no_data) if json_data.blank?

      connection.accounts.destroy_all

      json_data.each do |account_data|
        create_account(connection, account_data)
      end

      Success(connection)
    end

    def create_account(connection, account_data)
      connection.accounts.create(
        saltedge_id: account_data[:id],
        data: account_data
      )
    end
  end
end
