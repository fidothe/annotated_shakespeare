require 'nokogiri'

class Play
  def initialize(path)
    @path = path
  end

  def document
    @document ||= Nokogiri::XML(File.open(@path))
  end

  def title
    @title ||= document.css('teiHeader > fileDesc > titleStmt > title').text
  end
end
