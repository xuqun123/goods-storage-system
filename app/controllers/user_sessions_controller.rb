# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new; end

  def create
    @user = User.find_by_email(params[:email] || params.dig(:user, :email))
    if @user&.authenticate(params[:password] || params.dig(:user, :password))
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash[:error] = 'Incorrect email or password.'
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end
