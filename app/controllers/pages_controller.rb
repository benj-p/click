class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if current_user.is_teacher

    else
      #student stuff
    end
  end
end
