class Saltedge
  class Accounts
    class << self
      # TODO: добавить пагинацию или нолимит
      def list(connection_id)
        Saltedge.request(
          :get,
          "accounts?connection_id=#{connection_id}"
        )
      end
    end
  end
end
