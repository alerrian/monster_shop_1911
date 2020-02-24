class User::BaseController < ApplicationController
  before_action :require_user

  def require_user
    render file: "/public/404" unless (current_default? || current_merchant? || current_admin?)
  end
end
