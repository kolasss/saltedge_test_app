module Connections
  class Refresh
    include Callable
    include Dry::Monads[:result, :do]

    def call(connection)
      json = yield call_remote(connection)
      update(connection, json)
    end

    private

    def call_remote(connection)
      Saltedge.connections.refresh(connection.saltedge_id)
    end

    def update(connection, json)
      connection.assign_attributes(
        data: json[:data]
      )
      if connection.save
        Success(connection)
      else
        Failure(connection.errors)
      end
    end
  end
end
