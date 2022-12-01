class Saltedge
  class Customers
    class << self
      def create(identifier)
        Saltedge.request(
          :post,
          'customers',
          {
            data: {
              identifier: identifier
            }
          }
        )
      end
    end
  end
end
