#rails runner Tasks::Search.execute

require 'bundler'
Bundler.require

class Tasks::Search
	def self.execute
		p "start"
		count = Word.getWordCount()
		randId = rand(count) + 0
		@words = Word.skip(randId).limit(1)
		addCnt = 0
		for word in @words do
			for pagenum in 0..3 do
				begin
					#取得元のサイトを設定
					p word.text
					start_page_num = pagenum * 10
					escaped_url = URI.escape("https://www.google.com/search?q=" + word.text + "&oe=utf-8&hl=ja&start=" + start_page_num.to_s)
					p escaped_url
					doc = Nokogiri::HTML(open(escaped_url))
					puts doc.xpath("//*[@id='resultStats']/text()")
					doc.xpath('//h3/a').each do |link|
						search_urls = CGI.parse(link[:href])["/url?q"]
						BatchesHelper.openUrlAndSaveSite(search_urls[0])
						sleep(3)
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



