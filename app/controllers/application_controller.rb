# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    urls_path
  end

  def number_of_keywords
    current_user.urls.sum { |url| url.keywords.count }
  end

  def check_guest
    if current_user.email == "guest@example.com"
      redirect_to root_path, alert: "かんたんログイン中にその操作はできません。"
    end
  end
end
