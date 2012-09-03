# encoding: utf-8

require 'sinatra/base'
require 'json'
require 'play'
require 'data_mapper'
require 'user'
require 'credential'
require 'comment'
require 'annotation'
require 'securerandom'
require 'omniauth-browserid'

ROOT_DIR = File.expand_path('../../', __FILE__)

DataMapper.setup(:default, "sqlite://#{File.expand_path('db/annotated_shakespeare.db', ROOT_DIR)}")

DataMapper.auto_upgrade!

class OAAwareAuthenticityToken < Rack::Protection::AuthenticityToken
  def accepts?(env)
    return true if safe?(env)
    return true if env['omniauth.auth']
    super(env)
  end
end

class AnnotatedShakespeare < Sinatra::Base
  set :views, File.expand_path('views', ROOT_DIR)
  set :public_folder, File.expand_path('public', ROOT_DIR)
  set :session_secret, "df207bff3e06bba635a9e4f334238801"
  enable :sessions
  use OmniAuth::Builder do
    provider :browser_id, :verify_url => 'https://verifier.login.persona.org/verify'
  end
  use OAAwareAuthenticityToken

  # Support both GET and POST for OmniAuth callbacks
  [:get, :post].each do |method|
    send(method, "/auth/:provider/callback") do
      session.clear
      if user = User.from_auth_provider(params[:provider], env['omniauth.auth']['uid'])
        destination = '/'
      else
        user = User.create_from_auth_provider(params[:provider], env['omniauth.auth']['uid'])
        destination = '/profile'
      end
      session['user'] = user.id
      redirect to(destination)
    end
  end

  helpers do
    def csrf_token
      session[:csrf] ||= SecureRandom.hex
    end

    def current_user
      if session['user']
        @user ||= User.get(session['user'])
      end
    end
  end

  get '/profile' do
    halt 403 unless current_user
    erb :profile
  end

  post '/profile' do
    halt 403 unless current_user
    current_user.name = params[:name]
    current_user.save!
    redirect to('/')
  end

  get '/logout' do
    if current_user
      session.clear
      redirect to('logout')
    else
      erb :logout
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
    @annotations = @act.annotations
    erb :show
  end

  post '/plays/:id/act/:act_number/comments' do
    halt 403 unless current_user
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    current_user.comments.create!(:body => params['comment-body'], :commentable_type => :act, :commentable_id => @act.uid)
    redirect to("/plays/#{@play.slug}/act/#{@act.number}")
  end

  post '/plays/:id/act/:act_number/annotations' do
    halt 403 unless current_user
    @play = Play.find(params[:id])
    @act = @play.act(params[:act_number])
    annotation = current_user.annotations.create!(:text => params['annotation-text'], :act_uid => @act.uid, :annotated_id => params['annotation-id'])
    return [201, {'Content-Type' => 'application/json'}, annotation.to_json] if request.xhr?
    redirect to("/plays/#{@play.slug}/act/#{@act.number}")
  end
end
