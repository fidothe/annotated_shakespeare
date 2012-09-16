class AnnotatedShakespeare < Sinatra::Base
  post '/plays/:id/act/:act_number/comments' do
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    Comment.create!(:body => params['comment']['body'], 
                    :commentable_type => :act, 
                    :commentable_id => @act.number)
    erb :show
  end
end
