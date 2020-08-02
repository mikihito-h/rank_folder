class KeywordsController < ApplicationController
  before_action :set_url, only: [:destroy]
  before_action :set_keyword, only: [:destroy]

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

end
