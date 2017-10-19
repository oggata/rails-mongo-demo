#rails runner Tasks::Batch.execute

require 'bundler'
Bundler.require

class Tasks::Batch
	def self.execute
		p "start"

		@sites = Site.skip(0).limit(100)

		for site in @sites do

			p site.title

			origin_page_title = site.title
			origin_page_url = site.url
			origin_catgory_name = site.category_name

			@tags = []
			if site.tag1.length > 0
				@tags.push(site.tag1)
			end
			if site.tag2.length > 0
				@tags.push(site.tag2)
			end
			if site.tag3.length > 0
				@tags.push(site.tag3)
			end
			if site.tag4.length > 0
				@tags.push(site.tag4)
			end
			if site.tag5.length > 0
				@tags.push(site.tag5)
			end

			Anemone.crawl(origin_page_url,depth_limit: 10,:delay => 3,:skip_query_strings => false) do |anemone|
				# ここがメインの部分
				anemone.on_every_page do |page|
					# クロールした結果をごにょごにょ
					p page.url
					if !page.url then
						next
					end
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
						aaa = BatchesHelper.openUrlAndSaveArticle(article,page.url,title_jp,origin_page_title,origin_page_url,origin_catgory_name,@tags)
						p "----------------------->update"
						rescue Mongoid::Errors::DocumentNotFound => e
							p "----------------------->insert"
							p e
							article = Article.new
							aaa = BatchesHelper.openUrlAndSaveArticle(article,page.url,title_jp,origin_page_title,origin_page_url,origin_catgory_name,@tags)
						rescue Exception => e
							p "----------------------->error"
							p e
							next
					end
				end
			end
		end
	end
end


