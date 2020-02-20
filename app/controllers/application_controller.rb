class ApplicationController < ActionController::Base
	before_action :current_user
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_admin?, :current_merchant?

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

	def current_user
	 	return false unless session[:user_id]
	 	@current_user ||= User.find(session[:user_id])
 	end

	def current_admin?
		current_user && current_user.admin?
	end

	def current_user?
		current_user && current_user.user?
	end

	def current_merchant_employee?
		current_user && current_user.merchant?
	end

  def current_default?
    current_user && current_user.default?
  end
end
