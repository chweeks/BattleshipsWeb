require 'sinatra/base'
require_relative 'lib/board'
require_relative 'lib/cell'
require_relative 'lib/water'
require_relative 'lib/ship'
require_relative 'lib/player'
require_relative 'game_setup'

class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, 'views') }
  enable :sessions

  get '/' do
    erb :index
  end

  get '/name_input' do
    erb :name_input
  end

  post '/name_input' do
    session[:name] = params[:name]
    redirect ('/name_input') if params[:name].empty?
    redirect ('/game_setup')
  end

  get '/game_setup' do
    p session[:name]
    @name = session[:name]
    erb :game_setup
  end

  post '/game_setup' do
    redirect ('/game_setup')
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
