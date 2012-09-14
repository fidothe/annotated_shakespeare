class Play
  class NotFoundError < StandardError; end

  def initialize(path)
    @path = path
  end

  def self.find(slug)
    path = File.expand_path("../../plays/#{slug}.tei", 
                            __FILE__)
    raise NotFoundError unless File.file?(path)
    new(path)
  end
end
