get '/' do
  @title = "Plays of William Shakespeare"
  @plays = Play.all
  erb :index
end
