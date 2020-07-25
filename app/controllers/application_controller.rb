# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user

  def authenticate_user
    flash[:error] = 'You have to login first.'
    redirect_to login_url unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
