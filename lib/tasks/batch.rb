#rails runner Tasks::Batch.execute

require 'bundler'
Bundler.require

class Tasks::Batch
	def self.execute
		@sites = Site.skip(1).limit(100)

		for site in @sites do

			origin_page_title = site.title
			orgin_page_url = site.url
			origin_catgory_name = site.category_name

			Anemone.crawl(orgin_page_url,depth_limit: 10,:delay => 3,:skip_query_strings => false) do |anemone|
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

						aaa = BatchesHelper.openUrlAndSaveArticle(article,page.url,title_jp,origin_page_title,orgin_page_url,origin_catgory_name)
						rescue Mongoid::Errors::DocumentNotFound => e
							p e
							article = Article.new
							aaa = BatchesHelper.openUrlAndSaveArticle(article,page.url,title_jp,origin_page_title,orgin_page_url,origin_catgory_name)
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
