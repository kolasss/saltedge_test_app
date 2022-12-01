module Transactions
  class FetchAll
    include Callable
    include Dry::Monads[:result, :do]

    def call(account)
      json = yield list_remote(account)
      process_data(account, json[:data])
    end

    private

    def list_remote(account)
      Saltedge.transactions.list(account.connection.saltedge_id, account.saltedge_id)
    end

    def process_data(account, json_data)
      return Failure(:no_data) if json_data.blank?

      account.transactions.destroy_all

      json_data.each do |transaction_data|
        create_transaction(account, transaction_data)
      end

      Success(account)
    end

    def create_transaction(account, transaction_data)
      account.transactions.create(
        saltedge_id: transaction_data[:id],
        data: transaction_data
      )
    end
  end
end
