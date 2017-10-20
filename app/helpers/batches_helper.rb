module BatchesHelper

  public
  def self.hoge
  	pp ">>>>>>>>"
  end

  def self.openUrlAndSaveArticle(article,url,title,origin_page_title,orgin_page_url,origin_catgory_name,tags)
	open(url, 'User-Agent' => 'Googlebot/2.1') do |io|
		html = io.read
		#本文抽出
		body, title = ExtractContent.analyse(html)
		article.contributor_name = "xxx"
		article.url = url
		#画像操作
		line = html.match( /.+(jpeg|jpg|png|gif).+/ )
		linearray = line.to_s.split(/[ ()<>;,]/)
		image_array = []
		image_hash = {}
		roop_cnt = 0;
		linearray.each do |cut|
		  image_url = cut.to_s.match(/".+(\.jpeg|\.jpg|\.png|\.gif).*"/)
		  p image_url
		  if image_url != nil then
		  	image_array.push(image_url[0])
		  	image_hash[roop_cnt] = image_url[0]
		  end
		  roop_cnt+=1;
		end
		article.image = image_hash.to_json

		@article_tags = tags
		article.title = title
		article.body = body
		article.description = body

		article.tags = @article_tags
		article.site_name = origin_page_title
		#article.category_id = 1
		article.category_name = origin_catgory_name
		article.site_name = origin_page_title

		#画像
		if image_array.length >= 1
			article.images = image_array
		end
		article.pageview = 0
		article.ranking_number = 1

		#重要度
		article_weight = 0
		if title.length >= 5
			article_weight += 1
		end
		if body.length >= 5
			article_weight += 1
		end
		if image_array.length >= 1
			article_weight += 1
		end

		if article_weight <= 1
			article.isHidden = true
		else
			article.isHidden = false
		end

		article.weight = article_weight

		article.save


	end
  end


end
