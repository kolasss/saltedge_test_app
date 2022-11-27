class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_connection

  def index
    @accounts = @connection.accounts
  end

  def show
    @account = @connection.accounts.find(params[:id])
  end

  private

  def set_connection
    @connection = current_user.connections.find(params[:connection_id])
  end
end
