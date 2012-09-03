require 'nokogiri'

class Act
  attr_reader :number, :uid

  def initialize(play, act_number, uid)
    @play = play
    @number = act_number
    @uid = uid
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
    Comment.for(:act, @uid)
  end

  def annotations
    Annotation.for(@uid)
  end
end
