# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_number_of_users, only: [:create]
  before_action :check_guest, only: [:update, :destroy, :edit]

  private
    def check_number_of_users
      if User.count >= 60
        redirect_to root_path, alert: "既にユーザー数の上限に達している為、アカウント登録できませんでした。"
      end
    end

    def check_guest
      if resource.email == "guest@example.com"
        redirect_to root_path, alert: "かんたんログイン中にその操作はできません。"
      end
    end
end
