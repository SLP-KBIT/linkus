class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def admin_user!
    return if current_user.is_admin?
    redirect_to root_path, alert: '管理者用ページです'
  end

  def verified_user!
    return if current_user.is_verified?
    sign_out
    redirect_to root_path
  end
end
