# encoding: utf-8

require 'sinatra/base'
require 'play'

class AnnotatedShakespeare < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  get '/' do
    @title = "Plays of William Shakespeare"
    @plays = Play.all
    erb :index
  end

  get '/plays' do
    redirect to('/')
  end

  get '/plays/:id' do
    @play = Play.find(params[:id])
    @title = @play.title
    erb :play_index
  end

  get '/plays/:id/act' do
    redirect to("/plays/#{params[:id]}")
  end

  get '/plays/:id/act/:act_number' do
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    @act_number = params[:act_number].to_i
    @act_count = @play.acts.size
    @play_slug = params[:id]
    @title = @play.title + ": " + @act.title
    erb :show
  end
end
