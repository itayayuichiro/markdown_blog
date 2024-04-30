require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require_relative './lib/db_client'

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
    StackOverFlow.limit(10).each do |stack_over_flow|
      p stack_over_flow
      url = stack_over_flow.url
      begin
        page = agent.get(url)
      rescue => exception
        stack_over_flow.update(status: '例外')
        next
      end
      doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
      id = doc.at_css('.js-question')['data-questionid']
  
      title = doc.at_css('h1').text
      `echo #{title.inspect} > en.txt`
      ja_title = `trans en:ja file:///Users/itayayuuichirou/Documents/src/markdown_blog/en.txt`
  
      if doc.css('.js-post-body').length > 1
        p 'hit'
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
        stack_over_flow.update(status: '処理済み')
        sleep 2
      else
        stack_over_flow.update(status: '処理対象外')
      end
    end
  end
end

crawler = Crawler.new
crawler.main