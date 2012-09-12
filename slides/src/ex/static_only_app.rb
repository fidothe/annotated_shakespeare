# encoding: utf-8

require 'sinatra/base'

ROOT_DIR = File.expand_path('../../', __FILE__)

class AnnotatedShakespeare < Sinatra::Base
  set :public_folder,
      File.expand_path('public', ROOT_DIR)
end
