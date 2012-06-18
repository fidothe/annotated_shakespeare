# encoding: utf-8

require 'sinatra/base'
require 'play'

class AnnotatedShakespeare < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)

  get '/' do
    @plays = Play.all
    erb :index
  end

  get '/plays' do
    redirect to('/')
  end

  get '/plays/:id' do
    @play = Play.find(params[:id])
    erb :play_index
  end

  get '/plays/:id/act' do
  end

  get '/plays/:id/act/:act_number' do
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    erb :show
  end
end
