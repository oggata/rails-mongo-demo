#rails runner Tasks::Batch.execute

require 'bundler'
Bundler.require

class Tasks::Batch
	def self.execute

		logger = Logger.new('log/batch.log')

		p "start"
		count = Site.getSiteCount()
		randId = rand(count) + 0
		@sites = Site.skip(randId).limit(1)
		addCnt = 0
		for site in @sites do

			#取得元のサイトを設定
			p site.title
			origin_page_title = site.title
			origin_page_url = site.url
			origin_catgory_name = site.category_name

			#タグ
			@tags = []
			if site.tag1
				if site.tag1.length > 0
					@tags.push(site.tag1)
				end
			end
			if site.tag2
				if site.tag2.length > 0
					@tags.push(site.tag2)
				end
			end
			if site.tag3
				if site.tag3.length > 0
					@tags.push(site.tag3)
				end
			end
			if site.tag4
				if site.tag4.length > 0
					@tags.push(site.tag4)
				end
			end
			if site.tag5
				if site.tag5.length > 0
					@tags.push(site.tag5)
				end
			end

			#サイト名もタグに入れる
			@tags.push(origin_page_title)

			Anemone.crawl(origin_page_url,depth_limit: 10,:delay => 3,:skip_query_strings => false) do |anemone|
				# ここがメインの部分
				anemone.on_every_page do |page|
					# クロールした結果をごにょごにょ
					p page.url
					if !page.url then
						next
					end
					#上限は300件
					addCnt+=1
					if addCnt > 300
						p "finish"
						break
					end
					#ここから処理開始
					begin
						p "begin"
						#title
						title_jp = ""
						if page.doc.at('title') then
							title_jp = page.doc.at('title').inner_html
						else
							title_jp = "no title"
						end
						#article
						article  = Article.find_by(:url => page.url)
						setArticles = BatchesHelper.openUrlAndSaveArticle(article,page.url,title_jp,origin_page_title,origin_page_url,origin_catgory_name,@tags)
						p "----------------------->update"
						rescue Mongoid::Errors::DocumentNotFound => e
							p "----------------------->insert"
							#p e
							logger.info(e)

							article = Article.new
							setArticles = BatchesHelper.openUrlAndSaveArticle(article,page.url,title_jp,origin_page_title,origin_page_url,origin_catgory_name,@tags)
						rescue Exception => e
							p "----------------------->error"
							#p e
							logger.info(e)
							next
					end
				end
			end
		end
	end
end


