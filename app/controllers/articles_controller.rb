class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    #@articles = Article.all.desc(:created_at).limit(20)
    @articles = Article.desc(:created_at).limit(20)
    @todays_articles = [];
    for article in @articles do
      images_hash=JSON.parse(article.image)
      thumbnail_url = "";
      images_hash.each{|key, value|
        thumbnail_url = value.html_safe
      }
      @todays_article = { 'id' => article.id,'title_jp' => article.title_jp, 'body_jp' => article.body_jp[0,100], 'thumbnail_url' => thumbnail_url}
      @todays_articles.push(@todays_article);
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    images_hash=JSON.parse(@article.image)
    @thumbnail_images = []
    images_hash.each{|key, value|
      @thumbnail_images.push(value.html_safe);
    }
    #raise @thumbnail_images[0].inspect
    #@test = 100
    @article_title = @article.title_jp;
    @article_body = @article.body_jp;

    #記事コメント入力
    @comment = Comment.new
    @comment.article_id = @article.id;
    @comment.article_url = @article.url;
    #記事コメント一覧
    @comments = []
    begin
      #@comments = Comment.find_by(:article_id => @article.id)
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
