class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

	def current_user
	 	return false unless session[:user_id]
	 	@current_user ||= User.find(session[:user_id])
 	end

end
