json.extract! article, :id, :title_jp, :title_en, :title_fre, :title_ger, :title_chi, :title_ko, :body_jp, :body_en, :body_fre, :body_ger, :body_chi, :body_ko, :url, :genre_id, :contributor_id, :contributor_name, :image, :created_at, :updated_at
json.url article_url(article, format: :json)
