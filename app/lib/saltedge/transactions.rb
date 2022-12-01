class Saltedge
  class Transactions
    class << self
      # TODO: добавить пагинацию или нолимит
      def list(connection_id, account_id)
        Saltedge.request(
          :get,
          "transactions?connection_id=#{connection_id}&account_id=#{account_id}"
        )
      end
    end
  end
end
