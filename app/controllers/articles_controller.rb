class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # GET /articles
  # GET /articles.json
  def index

    #言語取得
    #path_dir = request.path_info
    #raise path_dir.inspect
    #if path_dir == "/en"
    #end

    @title = title;

    #カテゴリ取得
    @search_tag = params[:tag]

    #ページ取得
    current_page_num = params[:page]
    if !current_page_num then
      current_page_num = 1
    end
    row_per_page = 20
    skip_cnt = row_per_page * (current_page_num.to_i - 1)
    @current_page_num = current_page_num

    if !@search_tag then
      @todays_articles = Article.getTodaysArticles(skip_cnt,row_per_page);
    else
      @todays_articles = Article.getTodaysArticlesByTag(@search_tag,skip_cnt,row_per_page);
    end
    #raise @todays_articles.inspect
  end


  def list

  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    images_hash=JSON.parse(@article.image)
    @thumbnail_images = []
    images_hash.each{|key, value|
      @thumbnail_images.push(value.html_safe);
    }

    @title = title + " " + @article.title;

    #関連記事を検索する
    search_article_tag = ""
    search_article_tags = []
    for article_tag in @article.tags do
      #raise article_tag.inspect
      search_article_tag = article_tag
      search_article_tags.push(article_tag)
    end
    #raise search_article_tag.inspect
    @related_articles = Article.getRelatedArticlesByTag(search_article_tags);

    #記事コメント入力
    @comment = Comment.new
    @comment.article_id = @article.id;
    @comment.article_url = @article.url;
    #記事コメント一覧
    @comments = []
    begin
      @comments = Comment.all.where(:article_id => @article.id)
    rescue Exception => e
    end
    comment = @comments
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title_jp, :title_en, :title_fre, :title_ger, :title_chi, :title_ko, :body_jp, :body_en, :body_fre, :body_ger, :body_chi, :body_ko, :url, :genre_id, :integer, :contributor_name, :image)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :contributor, :score, :article_id, :article_url)
    end
end
