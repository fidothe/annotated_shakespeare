require 'nokogiri'
class Act
  attr_reader :number
  def initialize(play, act_number)
    @play = play
    @number = act_number
  end
  def title
    sel = "div:eq(#{number}) > head"
    @title ||= @play.document.css(sel).text
  end
  def xslt
    p = File.expand_path('../../xsl/tei2html.xsl', 
                          __FILE__)
    @xslt ||= Nokogiri::XSLT(File.open(p))
  end
  def html
    xslt.transform(@play.document,
      Nokogiri::XSLT.quote_params(['act_number', 
                                  number.to_s]))
  end
end
