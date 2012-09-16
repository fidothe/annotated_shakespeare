require 'sinatra/base'
require 'play'
require 'data_mapper'
require 'comment'

class AnnotatedShakespeare < Sinatra::Base
  post '/plays/:id/act/:act_number/comments' do
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    Comment.create!(:body => params['comment']['body'])
    erb :show
  end
end
