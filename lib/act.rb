require 'nokogiri'

class Act
  attr_reader :number

  def initialize(play, act_number)
    @play = play
    @number = act_number
  end

  def title
    @title ||= @play.document.css("div:eq(#{number}) > head").text
  end

  def xsl_path
    File.expand_path('../../xsl/tei2html.xsl', __FILE__)
  end

  def xslt
    @xslt ||= Nokogiri::XSLT(File.open(xsl_path))
  end

  def html
    xslt.transform(@play.document, Nokogiri::XSLT.quote_params(['act_number', number.to_s]))
  end

  def comments
    Comment.for(:act, @number)
  end
end
