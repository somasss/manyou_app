module Admin::UsersHelper
  def administrator
    current_user.admin == true
  end
end
