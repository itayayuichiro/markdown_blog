require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'

class Crawler
  def main
    agent = Mechanize.new
    f = File.open("./md/index.md", mode = "w")
    f.write("---\n")
    f.write("title: トップページ\n")
    f.write("---\n\n")
    f.write("## リンク一覧\n")
    Dir.glob("./docs/*.html").each do |file_path|
      page = open(file_path)
      doc = Nokogiri::HTML.parse(page, nil, 'utf-8')
      text = "- [#{doc.title}](#{file_path.gsub(/\/docs/, '')})"
      f.write("#{text}\n")
    end
  end
end

crawler = Crawler.new
crawler.main