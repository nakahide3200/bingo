class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  rescue_from Exception, with: :error_500
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActionController::RoutingError, with: :error_404

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def error_404(err = nil)
    logger.warn "Rendering 404 with exception: #{err.message}" if err

    render 'errors/error_404', status: :not_found
  end

  def error_500(err = nil)
    logger.error "Rendering 500 with exception: #{err.message}" if err

    render 'errors/error_500', status: :internal_server_error
  end
end
