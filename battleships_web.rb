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
      $board1.place(Ship.aircraft_carrier, session[:coord_ac].to_sym,:horizontally)
      $board1.place(Ship.destroyer, session[:coord_des].to_sym, :horizontally)
      $board1.place(Ship.battleship, session[:coord_bat].to_sym, :horizontally)
      $board1.place(Ship.submarine, session[:coord_sub].to_sym, :horizontally)
      $board1.place(Ship.patrol_boat, session[:coord_pb].to_sym, :horizontally)
      redirect ('/gameplay')
    else
      $board1 = Board.new(Cell)
      @name = session[:name]
      @grid = $board1.show
      erb :game_setup
    end
  end

  post '/game_setup' do
    session[:coord_ac] = params[:coord_ac]
    session[:coord_des] = params[:coord_des]
    session[:coord_bat] = params[:coord_bat]
    session[:coord_sub] = params[:coord_sub]
    session[:coord_pb] = params[:coord_pb]
    redirect ('/game_setup')
  end

  get '/gameplay' do
    if $board2
      @name = session[:name]
      @coord = session[:coord].to_sym
      $board2.shoot_at(@coord)
      $board1.rand_shoot
      return erb :game_over_win if !$board2.floating_ships?
      return erb :game_over_lose if !$board2.floating_ships?
      @grid = $board1.show
      @grid2 = $board2.show
      erb :gameplay
    else
      $board2 = Board.new(Cell)
      @name = session[:name]
      $board2.rand_place(Ship.battleship)
      $board2.rand_place(Ship.destroyer)
      $board2.rand_place(Ship.aircraft_carrier)
      $board2.rand_place(Ship.submarine)
      $board2.rand_place(Ship.patrol_boat)
      @grid = $board1.show
      @grid2 = $board2.show_invis
      erb :gameplay
    end
  end

  post '/gameplay' do
    session[:coord] = params[:coord]
    redirect ('/gameplay')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
