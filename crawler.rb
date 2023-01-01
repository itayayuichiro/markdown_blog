require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'

class Crawler
  def main
    agent = Mechanize.new
    35.times { |i|
      page = agent.get("file:///Users/itayayuuichirou/Documents/src/markdown_blog/docs/article#{i+1}.html")
      doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
      puts "- [#{doc.title}](./article#{i}.html)"
    }
  end
end

crawler = Crawler.new
crawler.main