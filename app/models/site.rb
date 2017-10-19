class Site
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :url, type: String
  field :target_path, type: String
  field :category_name, type: String
  field :tag1, type: String
  field :tag2, type: String
  field :tag3, type: String
  field :tag4, type: String
  field :tag5, type: String
end
