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
  field :genre_id, type: String
  field :integer, type: String
  field :contributor_name, type: String
  field :image, type: String
end