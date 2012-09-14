require 'sinatra/base'

class AnnotatedShakespeare < Sinatra::Base
  get '/' do
  end
  get '/plays' do
    redirect to('/')
  end
  get '/plays/:id' do
  end
  get '/plays/:id/act' do
    redirect to("/plays/#{params[:id]}")
  end
  get '/plays/:id/act/:act_number' do
  end
end
