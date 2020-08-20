# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :destroy]
  before_action :check_number_of_keywords, only: [:create]

  def index
    @urls = current_user.urls.order(created_at: :desc)
  end

  def show
    @keywords = @url.keywords.order(created_at: :desc)

    @line_chart_data = @keywords.map do |k|
      h = Hash.new
      k.rankings.each do |r|
        h[l(r.created_at, format: :short)] = r.rank
      end
      { name: k.keyword, data: h }
    end

    @number_of_rank_data = 0
    @keywords.each do |k|
      @number_of_rank_data += k.rankings.count
    end
  end

  def new
    @url = Url.new
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
        keywords_attributes: [:id, :keyword, :_destroy])
    end

    def check_number_of_keywords
      if number_of_keywords + url_params[:keywords_attributes].to_h.size > 5
        redirect_to root_path, alert: "検索ワードの数が上限を超えた為、URLを登録できませんでした。登録できる検索ワードは合計5個までです。"
      end
    end
end
