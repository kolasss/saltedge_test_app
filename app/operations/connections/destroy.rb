module Connections
  class Destroy
    include Callable
    include Dry::Monads[:result, :do]

    def call(connection)
      yield call_remote(connection)
      destroy(connection)
    end

    private

    def call_remote(connection)
      Saltedge.connections.destroy(connection.saltedge_id)
    end

    def destroy(connection)
      if connection.destroy
        Success(connection)
      else
        Failure(connection.errors)
      end
    end
  end
end
