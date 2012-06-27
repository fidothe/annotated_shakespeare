# encoding: utf-8

require 'sinatra/base'

class AnnotatedShakespeare < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  get '/' do
    @title = "Plays of William Shakespeare"
    @plays = {'julius' => 'Julius Caesar', 'richard' => 'Richard II'}
    erb :index
  end

  get '/plays' do
    redirect to('/')
  end

  get '/plays/:id' do
    plays = {'julius' => 'Julius Caesar', 'richard' => 'Richard II'}
    @play = plays[params[:id]]
    @title = @play
    @url_slug = params[:id]
    erb :play_index
  end

  get '/plays/:id/act' do
    redirect to("/plays/#{params[:id]}")
  end

  get '/plays/:id/act/:act_number' do
    plays = {'julius' => 'Julius Caesar', 'richard' => 'Richard II'}
    @play = plays[params[:id]]
    @act = params[:act_number]
    erb :show
  end
end
