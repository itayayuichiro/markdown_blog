require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require 'active_record' 


#DB接続設定
ActiveRecord::Base.establish_connection( 
  adapter:  "mysql2", 
  host:     "localhost", #ローカルのDBに接続します。
  username: "root", #ユーザー名
  password: "",  #設定したMySQLのパスワード
  database: "markdown_blog",  #接続したいDB名
)

class StackOverFlow < ActiveRecord::Base
end

class Crawler
  def main
    agent = Mechanize.new
    100.times do |i|
      url = "https://stackoverflow.com/questions?page=#{i+1}"
      page = agent.get(url)
      doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
      doc.css('#questions .js-post-summary').each do |div|
        href = div.at_css('.s-post-summary--content a')[:href]
        detail_url = 'https://stackoverflow.com' + href
        id = href.split('/')[2]
        begin
          StackOverFlow.create!(site_id:id.to_i, url: detail_url)
        rescue => e
          p e
        end
      end
    end
  end
end

crawler = Crawler.new
crawler.main


