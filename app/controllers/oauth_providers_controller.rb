class OauthProvidersController < ApplicationController
  before_action :authenticate_user!

  def authorize
    result = Connections::OauthAuthorize.call(current_user, params.except(:controller, :action))

    if result.success?
      redirect_to connection_path(result.value!), notice: 'Connection was successfully authorized.'
    else
      flash[:alert] = result.failure
      redirect_back_or_to connections_path
    end
  end
end
