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

  $board1 = Board.new(Cell)

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
    @name = session[:name]
    game = Game.new
    player1 = Player.new
    $board1.place(Ship.new(3), :A1)
    $board1.shoot_at(:A1)
    $board1.shoot_at(:B2)
    @grid = $board1.show
    erb :game_setup
  end

  post '/game_setup' do
    redirect ('/game_setup')
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
