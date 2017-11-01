# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = ENV["HOST_NAME"]

SitemapGenerator::Sitemap.create do


articleCnt = Article.getArticleCount()
#p articleCnt
loopCnt = ( articleCnt / 1000 ) - 1
for num in 0..loopCnt do
  #p num
  @articles = Article.desc(:created_at).skip(num * 1000).limit(1000)
  for article in @articles do
    add "/" + article.id
  end
end



  #@articles = Article.where(:weight.gte => 1).desc(:created_at).skip(0).limit(5000)
  #for article in @articles do
  #  add "/" + article.id
  #end



  # '/articles/:id' を追加する
  #Article.find_each do |article|
    #add article_path(article), :lastmod => article.updated_at
  #end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
