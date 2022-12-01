class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @account = Account.joins(:connection).merge(current_user.connections).find(params[:id])
    @transactions = @account&.transactions
  end
end
