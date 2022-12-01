class Saltedge
  class Connections
    class << self
      def create(customer_id:, provider_code:)
        Saltedge.request(
          :post,
          'connections',
          {
            data: data.merge(
              {
                customer_id: customer_id,
                country_code: 'XF',
                provider_code: provider_code
              }
            )
          }
        )
      end

      def refresh(connection_id)
        Saltedge.request(
          :put,
          "connections/#{connection_id}/refresh",
          { data: { attempt: attempt } }
        )
      end

      def reconnect(connection_id)
        Saltedge.request(
          :put,
          "connections/#{connection_id}/reconnect",
          { data: data }
        )
      end

      def destroy(connection_id)
        Saltedge.request(
          :delete,
          "connections/#{connection_id}"
        )
      end

      def show(connection_id)
        Saltedge.request(
          :get,
          "connections/#{connection_id}"
        )
      end

      def data
        {
          consent: {
            scopes: %w[account_details transactions_details]
          },
          attempt: attempt,
          credentials: {
            login: 'username',
            password: 'secret'
          }
        }
      end

      def attempt
        {
          fetch_scopes: %w[accounts transactions]
        }
      end
    end
  end
end
