class LogsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :create

  def create
    @article = Article.find(params[:article_id])
    @log = @article.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "キャンプログを追加しました！"
    redirect_to article_path(@article)
  end

  def destroy
    @log = Log.find(params[:id])
    @article = @log.article
    if current_user == @article.user
      @log.destroy
      flash[:success] = "キャンプログを削除しました"
    end
    redirect_to article_url(@article)
  end

  private

  def correct_user
    article = current_user.articles.find_by(id: params[:article_id])
    redirect_to root_url if article.nil?
  end
end
