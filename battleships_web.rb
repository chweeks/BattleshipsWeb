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
    if $board1
      @name = session[:name]
    p  @coord = session[:coord].to_sym
      $board1.shoot_at(@coord)
      return erb :game_over if !$board1.floating_ships?
      @grid = $board1.show
      erb :game_setup
    else
      $board1 = Board.new(Cell)
      @name = session[:name]
      $board1.rand_place(Ship.battleship)
      $board1.rand_place(Ship.destroyer)
      $board1.rand_place(Ship.aircraft_carrier)
      $board1.rand_place(Ship.submarine)
      $board1.rand_place(Ship.patrol_boat)
      @grid = $board1.show
      erb :game_setup
    end
  end

  post '/game_setup' do
    session[:coord] = params[:coord]
    redirect ('/game_setup')
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
