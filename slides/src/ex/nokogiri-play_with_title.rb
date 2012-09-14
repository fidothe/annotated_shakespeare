require 'nokogiri'

class Play
  def initialize(path)
    @path = path
  end

  def document
    @document ||= Nokogiri::XML(File.open(@path))
  end

  def title
    selector = 'teiHeader > fileDesc > titleStmt > title'
    @title ||= document.css(selector).text
  end
end
