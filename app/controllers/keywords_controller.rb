# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :set_url, only: [:destroy, :new, :create]
  before_action :set_keyword, only: [:destroy]

  def new
    @keyword = Keyword.new
  end

  def create
    @keyword = @url.keywords.new(keyword_params)
    if @keyword.save
      redirect_to url_path(params[:url_id]), notice: "検索ワード「#{@keyword.keyword}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    @keyword.destroy
    redirect_to @url, notice: "検索ワード「#{@keyword.keyword}」を削除しました。"
  end

  private
    def set_keyword
      @keyword = @url.keywords.find(params[:id])
    end

    def set_url
      @url = current_user.urls.find(params[:url_id])
    end

    def keyword_params
      params.require(:keyword).permit(:keyword)
    end
end
