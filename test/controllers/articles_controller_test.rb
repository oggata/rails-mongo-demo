require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_url, params: { article: { body_chi: @article.body_chi, body_en: @article.body_en, body_fre: @article.body_fre, body_ger: @article.body_ger, body_jp: @article.body_jp, body_ko: @article.body_ko, contributor_name: @article.contributor_name, genre_id: @article.genre_id, image: @article.image, integer: @article.integer, title_chi: @article.title_chi, title_en: @article.title_en, title_fre: @article.title_fre, title_ger: @article.title_ger, title_jp: @article.title_jp, title_ko: @article.title_ko, url: @article.url } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article), params: { article: { body_chi: @article.body_chi, body_en: @article.body_en, body_fre: @article.body_fre, body_ger: @article.body_ger, body_jp: @article.body_jp, body_ko: @article.body_ko, contributor_name: @article.contributor_name, genre_id: @article.genre_id, image: @article.image, integer: @article.integer, title_chi: @article.title_chi, title_en: @article.title_en, title_fre: @article.title_fre, title_ger: @article.title_ger, title_jp: @article.title_jp, title_ko: @article.title_ko, url: @article.url } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
