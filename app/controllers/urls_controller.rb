# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]

  def index
    @urls = current_user.urls
  end

  def show
  end

  def new
    @url = Url.new
  end

  def edit
  end

  def create
    @url = current_user.urls.new(url_params)
    if @url.save
      redirect_to @url, notice: "Url was successfully created."
    else
      render :new
    end
  end

  def update
    if @url.update(url_params)
      redirect_to @url, notice: "Url was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @url.destroy
    redirect_to urls_url, notice: "Url was successfully destroyed."
  end

  private
    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
      params.require(:url).permit(:url)
    end
end
