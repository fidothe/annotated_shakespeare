# encoding: utf-8

require 'sinatra/base'

class AnnotatedShakespeare < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  get '/' do
    @title = "Index"
    erb :index
  end
end
