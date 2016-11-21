require 'nokogiri'
require 'open-uri'
require 'Mysql2'
require 'openssl'
require 'json'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
hash_tripadvisor = Hash.new

k = 0
for i in 0..34
	begin

		doc = Nokogiri::HTML(open("https://www.tripadvisor.com/Attraction_Review-g294229-d1744267-Reviews-or#{i}0-Thousand_Islands-Jakarta_Java.html#REVIEWS"))

		# Get all links which contain main article
		dokumen_resik = doc.css('.reviewSelector')

		for j in 0...dokumen_resik.length
			hash_tripadvisor["tripadvisor_monas_#{k}"] = dokumen_resik[j].css('p').first.content.gsub("\n", "").gsub("\s+", " ")
			k += 1
		end

	rescue
		puts "error link #{i}"
	end
end

File.open("tripadvisor_Ancol_Thousand_Islands-Jakarta.json", 'w') { |file| file.write(hash_tripadvisor.to_json) }