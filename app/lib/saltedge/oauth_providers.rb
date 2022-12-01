class Saltedge
  class OauthProviders
    class << self
      def create(customer_id:, provider_code:)
        Saltedge.request(
          :post,
          'oauth_providers/create',
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

      def authorize(connection_id, query_string)
        Saltedge.request(
          :put,
          'oauth_providers/authorize',
          {
            data: {
              connection_id: connection_id,
              query_string: query_string
            }
          }
        )
      end

      def reconnect(connection_id)
        Saltedge.request(
          :post,
          'oauth_providers/reconnect',
          {
            data: data.merge({ connection_id: connection_id })
          }
        )
      end

      private

      def return_to_url
        Rails.application.routes.url_helpers
             .oauth_providers_authorize_url(host: ENV.fetch('HOST_URL'))
      end

      def data
        {
          consent: {
            scopes: %w[account_details transactions_details]
          },
          attempt: {
            fetch_scopes: %w[accounts transactions],
            return_to: return_to_url
          },
          return_connection_id: true # не работает на тесте
        }
      end
    end
  end
end
