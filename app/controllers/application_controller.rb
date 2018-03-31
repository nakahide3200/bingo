class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
