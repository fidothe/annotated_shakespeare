class Play
  def initialize(path)
    @path = path
  end

  def self.all
    path = File.expand_path('../../plays', __FILE__)
    Dir.glob("#{path}/*.tei").map { |path| new(path) }
  end
end
