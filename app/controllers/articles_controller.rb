class ArticlesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]

  def index
    @log = Log.new
    respond_to do |format|
      format.html
      format.csv {
        send_data render_to_string,
                  filename: "みんなの投稿一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv"
      }
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "投稿が登録されました！"
      Log.create(article_id: @article.id, content: @article.camp_memo)
      redirect_to article_path(@article)
    else
      render 'articles/new'
    end
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @log = Log.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "投稿情報が更新されました！"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if current_user.admin? || current_user?(@article.user)
      @article.destroy
      flash[:success] = "投稿が削除されました"
      redirect_to request.referrer == user_url(@article.user) ? user_url(@article.user) : root_url
    else
      flash[:danger] = "他人の投稿は削除できません"
      redirect_to root_url
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :prefecture_id, :shooting,
                                    :reference, :popularity, :camp_memo, :picture)
  end

  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    redirect_to root_url if @article.nil?
  end
end
