class PassthroughController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if !current_user
      path = home_path
    elsif current_user.is_teacher
      path = curriculums_path
    elsif !current_user.is_teacher
      path = dashboard_user_path(current_user)
    end
    redirect_to path
  end
end
