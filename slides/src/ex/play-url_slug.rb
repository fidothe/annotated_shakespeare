class Play
  def initialize(path)
    @path = path
  end

  def slug
    @slug ||= File.basename(@path, '.tei')
  end
end
