# frozen_string_literal: true

class Api::V1::RanksController < Api::V1::ApplicationController
  def index
    @urls = User.find_by!(api_key: params[:api_key]).urls
  end
end
