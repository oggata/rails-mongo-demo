class ListsController < ApplicationController
  
  def articles
    #カテゴリ取得
    @search_tag = params[:tag]
    if @search_tag == "ALL"
      @search_tag = nil
    end
    #raise @search_tag.inspect

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

    @title = "「" +  @search_tag  + "」のリスト(" + current_page_num.to_s + "ページ目)";
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
