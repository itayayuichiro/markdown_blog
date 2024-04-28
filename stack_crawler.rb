require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'

class Crawler
  def get_text(f, node)
    node.children.each do |child|
      if child.name == 'pre'
        f.write("```\n")
        f.write("#{child.text}\n")
        f.write("```\n")
      elsif child.name == 'p'
        `echo #{child.text.inspect} > en.txt`
        ja_text =  `trans en:ja file:///Users/itayayuuichirou/Documents/src/markdown_blog/en.txt`
        f.write("#{ja_text}\n")
      end
    end
  end

  def main
    agent = Mechanize.new
    url = "https://stackoverflow.com/questions/52255506/find-last-created-at-record"
    page = agent.get(url)
    doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
    id = doc.at_css('.js-question')['data-questionid']

    title = doc.at_css('h1').text
    `echo #{title.inspect} > en.txt`
    ja_title = `trans en:ja file:///Users/itayayuuichirou/Documents/src/markdown_blog/en.txt`

    f = File.open("./md/s#{id}.md", mode = "w")
    f.write("---\n")
    f.write("title: '#{ja_title.chomp}'\n")
    f.write("---\n\n")
    f.write("## 概要\n")

    # 質問文
    get_text(f, doc.at_css('.js-post-body'))

    # 回答
    f.write("## 解決策\n")
    get_text(f, doc.css('.js-post-body')[1])
  end
end

crawler = Crawler.new
crawler.main