class User::ProfileController < User::BaseController
  def show
    @user = current_user
  end
end
