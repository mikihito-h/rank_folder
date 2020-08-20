# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    urls_path
  end

  def number_of_keywords
    number_of_keywords = 0
    current_user.urls.each do |url|
      number_of_keywords += url.keywords.count
    end
    number_of_keywords
  end

  def check_guest
    if current_user.email == "guest@example.com"
      redirect_to root_path, alert: "ゲストユーザーはその操作の権限がありません。"
    end
  end
end
