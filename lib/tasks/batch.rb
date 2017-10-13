#rails runner Tasks::Batch.execute

require 'bundler'
Bundler.require

class Tasks::Batch
  def self.execute
    # 実行したいコードを書く
    p "Hello world"

    target_url = ENV['BATCH_TARGET_URL']
    target_path = ENV['BATCH_TARGET_PATH']

	Anemone.crawl(target_url,depth_limit: 10,:delay => 1,:skip_query_strings => false) do |anemone|

		# クロールするごとに呼び出される
		anemone.focus_crawl do |page|
			# 条件に一致するリンクだけ残す
			# この `links` はanemoneが次にクロールする候補リスト
			page.links.keep_if { |link|
				link.to_s.match(target_path)
			} 
		end


		# ここがメインの部分
		anemone.on_every_page do |page|
	    	# クロールした結果をごにょごにょ
	    	p page.url

	    	if !page.url then
	    		next
	    	end

			begin
				p "----------------------->update"
				article  = Article.find_by(:url => page.url)

				open(page.url, 'User-Agent' => 'Googlebot/2.1') do |io|
					html = io.read
					#本文抽出
					body, title = ExtractContent.analyse(html)
					#article = Article.new
					if page.doc.at('title') then
						article.title_jp = page.doc.at('title').inner_html
					else
						article.title_jp = "no title"
					end
					#article.body_jp = body[1,3000]
					article.body_jp = body
					article.contributor_name = "xxx"
					article.url = page.url
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
					  	#p image_url[0]
					  	image_array.push(image_url[0])
					  	image_hash[roop_cnt] = image_url[0]
					  end
					  roop_cnt+=1;
					end
					article.image = image_hash.to_json
					article.save
				end


			rescue Mongoid::Errors::DocumentNotFound => e
				p "----------------------->insert"
				open(page.url, 'User-Agent' => 'Googlebot/2.1') do |io|
					html = io.read
					#本文抽出
					body, title = ExtractContent.analyse(html)
					article = Article.new

					if page.doc.at('title') then
						article.title_jp = page.doc.at('title').inner_html
					else
						article.title_jp = "no title"
					end

					article.body_jp = body
					article.contributor_name = "xxx"
					article.url = page.url
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
					  	#p image_url[0]
					  	image_array.push(image_url[0])
					  	image_hash[roop_cnt] = image_url[0]
					  end
					  roop_cnt+=1;
					end
					article.image = image_hash.to_json
					article.save
				end

			rescue Exception => e
				p "----------------------->error"
				p e
				next

			end

		end
	end
  end
end