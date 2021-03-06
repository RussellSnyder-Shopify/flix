class ApplicationController < ActionController::Base
  include Pagy::Backend
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  private

  def require_signin
    session[:intended_url] = request.url
    redirect_to new_session_url, alert: 'Please sign in first!' unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def current_user_admin?
    current_user&.admin?
  end

  helper_method :current_user_admin?

  def current_user_super_admin?
    current_user&.super_admin?
  end

  helper_method :current_user_super_admin?

  def require_admin
    redirect_to movies_url, alert: 'Unauthorized access!' unless current_user_admin?
  end
end
