module UsersHelper
  def accessible_user
    @user == current_user ||  current_user.admin == true
  end
end
