get '/plays/:id/act/:act_number' do
  @play = Play.find(params[:id])
  @act = @play.act(params[:act_number])
  @title = @play.title + ": " + @act.title
  @comments = @act.comments
  erb :show
end
