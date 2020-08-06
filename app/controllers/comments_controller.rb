class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @article = Article.find(params[:article_id])
    @user = @article.user
    @comment = @article.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@article.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @article = @comment.article
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to article_url(@article)
  end
end
