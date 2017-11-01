module BatchesHelper

  public
  def self.hoge
  	pp ">>>>>>>>"
  end

  def self.openUrlAndSaveSite(search_url)
	begin
		p "begin"
		site  = Site.find_by(:url => search_url)
		rescue Mongoid::Errors::DocumentNotFound => e
			p "----------------------->insert"
			#p e
			escaped_url = URI.escape(search_url)
			doc = Nokogiri::HTML(open(escaped_url))
			site = Site.new
			#
			#doc = doc.force_encoding("UTF-8")
			site.title = doc.title
			site.url = search_url
			site.description = doc.xpath('/html/head/meta[@name="description"]/@content').to_s 
			tags_txt = doc.xpath('/html/head/meta[@name="keywords"]/@content').to_s
			tags = tags_txt.split(",")
			#puts tags
			if tags[0]
				site.tag1 = tags[0]
			end
			if tags[1]
				site.tag2 = tags[1]
			end
			if tags[2]
				site.tag3 = tags[2]
			end
			if tags[3]
				site.tag4 = tags[3]
			end
			if tags[4]
				site.tag5 = tags[4]
			end
			site.save
		rescue Exception => e
			p "----------------------->error"
			#p e
	end
  end

  def self.openUrlAndSaveArticle(article,url,title,origin_page_title,orgin_page_url,origin_catgory_name,tags)
	
	open(url, 'User-Agent' => 'Googlebot/2.1') do |io|
		html = io.read
		#本文抽出
		body, title = ExtractContent.analyse(html)
		article.contributor_name = "xxx"
		article.url = url

		#nokogiri
		doc = Nokogiri::HTML(html)
		#doc = String.force_encoding("UTF-8")
		#site.description = doc.xpath('/html/head/meta[@name="description"]/@content').to_s 
		tags_txt = doc.xpath('/html/head/meta[@name="keywords"]/@content').to_s
		tags = tags_txt.split(",")
		p tags

		#画像操作
		line = html.match( /.+(jpeg|jpg|png|gif).+/ )
		linearray = line.to_s.split(/[ ()<>;,]/)
		image_array = []
		image_hash = {}
		roop_cnt = 0;
		linearray.each do |cut|
		  image_url = cut.to_s.match(/".+(\.jpeg|\.jpg|\.png|\.gif).*"/)
		  #p image_url
		  if image_url != nil then
		  	image_array.push(image_url[0])
		  	image_hash[roop_cnt] = image_url[0]
		  end
		  roop_cnt+=1;
		end
		article.image = image_hash.to_json
		article.title = title
		article.body = body
		article.description = body

		#タグ
		article.tags = tags
		article.site_name = origin_page_title
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
