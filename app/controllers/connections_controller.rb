class ConnectionsController < ApplicationController
  before_action :set_connection, only: %i[show refresh reconnect fetch destroy]
  before_action :authenticate_user!

  def index
    @connections = current_user.connections
  end

  def show
    @connection = current_user.connections.find(params[:id])
    @accounts = @connection&.accounts
  end

  def new
    @provider = Provider.find_by(code: 'fake_oauth_client_xf')
    # @fields = Providers::ExtractFormFields.call(@provider).value_or([])
  end

  def create
    provider = Provider.find_by(code: params[:provider_code])
    result = Connections::OauthCreate.call(current_user.customer, provider)

    if result.success?
      # redirect_to connection_path(result.value!), notice: "Connection was successfully created."
      redirect_to result.value![:redirect_to], allow_other_host: true
    else
      flash[:alert] = result.failure
      redirect_back_or_to connections_path
    end
  end

  def refresh
    result = Connections::Refresh.call(@connection)

    if result.success?
      redirect_to connection_path(result.value!), notice: 'Refresh sent.'
    else
      flash[:alert] = result.failure
      redirect_back_or_to connections_path
    end
  end

  def reconnect
    result = Connections::Reconnect.call(@connection)

    if result.success?
      redirect_to connection_path(result.value!), notice: 'Reconnected.'
    else
      flash[:alert] = result.failure
      redirect_back_or_to connections_path
    end
  end

  def refresh_all
    RefreshConnectionsJob.perform_later
    redirect_back_or_to connections_path, notice: 'Refresh all connections enqueued.'
  end

  def fetch
    result = Connections::Fetch.call(@connection)

    if result.success?
      redirect_to connection_path(result.value!), notice: 'Fetched.'
    else
      flash[:alert] = result.failure
      redirect_back_or_to connections_path
    end
  end

  def destroy
    result = Connections::Destroy.call(@connection)

    if result.success?
      redirect_to connections_path, notice: 'Destroyed.'
    else
      flash[:alert] = result.failure
      redirect_back_or_to connections_path
    end
  end

  private

  def set_connection
    @connection = current_user.connections.find(params[:id])
  end

  def connection_params
    params.require(:car).permit(:title, :mark)
  end
end
