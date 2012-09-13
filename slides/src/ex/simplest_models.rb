class Play
  attr_reader :title, :author, :acts
  def initialize(title, author, acts)
    @title = title
    @author = author
    @acts = acts
  end
end
class Act < Struct.new(:number, :title, :text)
end

act_1 = Act.new(1, 'Act One', 'Act text')
act_2 = Act.new(2, 'Act Two', 'Act text')
play = Play.new('Caesar', 'Will', [act_1, act_2])
