#include Mongoid::Timestamps

class Article
  include Mongoid::Document
  field :title_jp, type: String
  field :title_en, type: String
  field :title_fre, type: String
  field :title_ger, type: String
  field :title_chi, type: String
  field :title_ko, type: String
  field :body_jp, type: String
  field :body_en, type: String
  field :body_fre, type: String
  field :body_ger, type: String
  field :body_chi, type: String
  field :body_ko, type: String
  field :url, type: String
  field :genre_id, type: Integer
  field :contributor_id, type: String
  field :contributor_name, type: String
  field :image, type: String
  field :created_at, type: Time, default: -> { Time.current }
  field :updated_at, type: Time, default: -> { Time.current }
  field :title, type: String
  field :body,  type: String
  field :description , type:String
  field :tags, type: Array
  field :site_name, type:String
  field :category_id, type: String
  field :category_name, type: String
  field :images, type: Array
  field :movies, type: Array
  field :pageview, type: Integer
  field :ranking_number, type: Integer
  field :weight,  type: String
  field :isHidden, type: Boolean

  def self.getTodaysArticles(skip_cnt,row_per_page)
    @articles = Article.where(:weight.gte => 2).desc(:created_at).skip(skip_cnt).limit(row_per_page)
    #@articles = Article.all
    @todays_articles = [];
    for article in @articles do
      artcle_image_txt = "";
      if article.images != nil
        for artcle_image in article.images do
          #print("Color = " + artcle_image + "¥n")
          artcle_image_txt = artcle_image;
        end
        #raise article.images.inspect
      end

      images_hash=JSON.parse(article.image)
      thumbnail_url = "";
      images_hash.each{|key, value|
        thumbnail_url = value.html_safe
      }
      @todays_article = { 'id' => article.id,'title' => article.title[0,20], 'body' => article.body[0,200], 'thumbnail_url' => thumbnail_url, 'site_name' => article.site_name}
      @todays_articles.push(@todays_article);
    end
    return @todays_articles
  end

  def self.getRelatedArticles()
    @articles = Article.where(:weight.gte => 2).desc(:created_at).skip(0).limit(5)
    @related_articles = [];
    for article in @articles do
      images_hash=JSON.parse(article.image)
      thumbnail_url = "";
      images_hash.each{|key, value|
        thumbnail_url = value.html_safe
      }
      @related_article = { 'id' => article.id,'title' => article.title[0,20], 'body' => article.body[0,200], 'thumbnail_url' => thumbnail_url, 'site_name' => article.site_name}
      @related_articles.push(@related_article);
    end
    return @related_articles
  end

end

#確認
#db.articles.getIndexSpecs()

#multi key index
#db.articles.createIndex({tags: 1})
#db.articles.createIndex({weight:1})

#unique index
#db.articles.ensureIndex({url:1},{unique:true});

=begin
  
[
  {
    "v" : 1,
    "key" : {
      "_id" : 1
    },
    "ns" : "rails_mongo_demo_development7.articles",
    "name" : "_id_"
  },
  {
    "v" : 1,
    "key" : {
      "tags" : 1
    },
    "ns" : "rails_mongo_demo_development7.articles",
    "name" : "tags_1"
  },
  {
    "v" : 1,
    "key" : {
      "url" : 1
    },
    "unique" : true,
    "ns" : "rails_mongo_demo_development7.articles",
    "name" : "url_1"
  },
  {
    "v" : 1,
    "key" : {
      "weight" : 1
    },
    "ns" : "rails_mongo_demo_development7.articles",
    "name" : "weight_1"
  }
  
=end







