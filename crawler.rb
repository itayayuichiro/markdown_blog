require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'

class Crawler
  def main
    agent = Mechanize.new
    100.times { |i|
      begin
        page = agent.get("file:///Users/itayayuuichirou/Documents/src/markdown_blog/docs/article#{i+1}.html")
        doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
        puts "- [#{doc.title}](./article#{i+1}.html)"
        page = agent.get("file:///Users/itayayuuichirou/Documents/src/markdown_blog/docs/article#{i+1}_en.html")
        doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
        puts "- [#{doc.title}](./article#{i+1}_en.html)"
      rescue
        # handle the exception here
      end
    }
  end
end

crawler = Crawler.new
crawler.main