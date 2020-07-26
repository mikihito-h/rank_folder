# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :destroy]

  def index
    @urls = current_user.urls.order(created_at: :desc)
  end

  def show
  end

  def new
    @url = Url.new
    @url.keywords.build
  end

  def create
    @url = current_user.urls.new(url_params)
    if @url.save
      redirect_to @url, notice: "Urlを登録しました。"
    else
      render :new
    end
  end

  def destroy
    @url.destroy
    redirect_to urls_url, notice: "Urlを削除しました。"
  end

  private
    def set_url
      @url = current_user.urls.find(params[:id])
    end

    def url_params
      params.require(:url).permit(
        :url,
        keywords_attributes: [:keyword])
    end
end
