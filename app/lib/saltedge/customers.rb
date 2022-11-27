class Saltedge::Customers
  class << self
    def create(identifier)
      Saltedge.request(
        :post,
        'https://www.saltedge.com/api/v5/customers',
        {
          data: {
            identifier: identifier
          }
        }
      )
    end
  end
end
