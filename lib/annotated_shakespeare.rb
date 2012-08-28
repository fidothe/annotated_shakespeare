# encoding: utf-8

require 'sinatra/base'
require 'play'
require 'data_mapper'
require 'comment'
require 'securerandom'

ROOT_DIR = File.expand_path('../../', __FILE__)

DataMapper.setup(:default, "sqlite://#{File.expand_path('db/annotated_shakespeare.db', ROOT_DIR)}")

DataMapper.auto_upgrade!

class AnnotatedShakespeare < Sinatra::Base
  set :views, File.expand_path('views', ROOT_DIR)
  set :public_folder, File.expand_path('public', ROOT_DIR)
  set :session_secret, "df207bff3e06bba635a9e4f334238801"
  enable :sessions
  use Rack::Protection::AuthenticityToken

  helpers do
    def csrf_token
      session[:csrf] ||= SecureRandom.hex
    end
  end

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
    @comments = @act.comments
    erb :show
  end

  post '/plays/:id/act/:act_number/comments' do
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    Comment.create!(:body => params['comment-body'], :commentable_type => :act, :commentable_id => @act.number)
    redirect to("/plays/#{@play.slug}/act/#{@act.number}")
  end
end
