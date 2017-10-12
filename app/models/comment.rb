class Comment
  include Mongoid::Document
  field :comment, type: String
  field :contributor, type: Integer
  field :score, type: Integer
  field :article_id, type: String
  field :article_url, type: String
end
