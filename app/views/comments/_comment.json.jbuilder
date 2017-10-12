json.extract! comment, :id, :comment, :contributor, :score, :article_id, :article_url, :created_at, :updated_at
json.url comment_url(comment, format: :json)
