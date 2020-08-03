# frozen_string_literal: true

class Api::V1::RanksController < ApplicationController
  def index
    @urls = Url.all
  end
end
