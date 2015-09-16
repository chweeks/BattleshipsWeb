require 'sinatra/base'
require_relative 'board'
require_relative 'cell'
require_relative 'water'
require_relative 'ship'
# enable :sessions

class BattleshipsWeb < Sinatra::Base

  set :views, proc { File.join(root, 'views') }

  get '/' do
    erb :index
  end

  get '/name_input' do
    @name = params[:name]
    @board = Board.new(Cell)
    erb :name_input
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
