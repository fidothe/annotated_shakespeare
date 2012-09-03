require 'nokogiri'
require 'act'

class Play
  class NotFoundError < StandardError; end

  def initialize(path)
    @path = path
  end

  def self.find(slug)
    path = File.expand_path("../../plays/#{slug}.tei", __FILE__)
    raise NotFoundError unless File.file?(path)
    new(path)
  end
  
  def self.all
    path = File.expand_path('../../plays', __FILE__)
    Dir.glob("#{path}/*.tei").collect { |path| new(path) }
  end

  def document
    @document ||= Nokogiri::XML(File.open(@path))
  end

  def title
    @title ||= document.css('teiHeader > fileDesc > titleStmt > title').text
  end

  def slug
    @slug ||= File.basename(@path, '.tei')
  end

  def acts
    @acts ||= (1..(document.css('div').length)).to_a.collect { |act_number| Act.new(self, act_number, "#{slug}-#{act_number}") }
  end

  def act(act_number)
    raise NotFoundError if act_number == 0
    act = acts[act_number.to_i - 1]
    raise NotFoundError if act.nil?
    act
  end
end
