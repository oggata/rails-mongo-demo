json.extract! site, :id, :title, :description, :url, :target_path, :category_name, :created_at, :updated_at
json.url site_url(site, format: :json)
