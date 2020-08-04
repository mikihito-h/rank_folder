# frozen_string_literal: true

class Api::V1::RanksController < ApplicationController
  before_action :set_urls, only: [:index]
  skip_before_action :authenticate_user!

  def index
  end

  private
    def set_urls
      if User.find_by(api_key: params[:api_key])
        user = User.find_by(api_key: params[:api_key])
        @urls = user.urls
      end
    end
end
