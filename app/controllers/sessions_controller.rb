class SessionsController < ApplicationController

  def new
    if !session[:user_id].nil?
      redirect_to "/admin/dashboard"
      flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
    elsif current_merchant?
      redirect_to "/merchant_employee/dashboard"
      flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
    elsif current_default?
      redirect_to "/user/profile"
      flash[:notice] = "You are already logged in as #{current_user.name}, to log out please select 'Log Out' at the top of your page."
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user != nil && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "#{user.name}, has been successfully logged in!"
      if user.admin?
        redirect_to '/admin/dashboard'
        flash[:success] = "#{user.name}, has been successfully logged in!"
      elsif user.merchant_employee?
        redirect_to '/merchant_employee/dashboard'
        flash[:success] = "#{user.name}, has been successfully logged in!"
      else user.default?
        redirect_to '/user/profile'
        flash[:success] = "#{user.name}, has been successfully logged in!"
      end
    else
      flash.now[:notice] = "Your Log in attempt failed, Wrong email or password"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:cart)
    flash[:success] = 'You have been successfully logged out!!'
    redirect_to '/welcome'
  end
end
