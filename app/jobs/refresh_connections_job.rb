class RefreshConnectionsJob < ApplicationJob
  queue_as :default

  def perform
    Connection.all.each { |connection| Connections::Refresh.call(connection) }
  end
end
