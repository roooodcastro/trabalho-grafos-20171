require 'sinatra' # Sinatra web framework
require 'pry'
require_relative 'autoload' # Actual program classes and modules

set :public_folder, 'public'

get '/' do
  # Gets the number of vertices from params, with 50 as default
  # Limits the absolute maximum number to 1000, to prevent eternal load times
  num_vertices = [(params[:n].to_i || 50), 1000].min
  @graph = Graph.create_random_graph(num_vertices)
  erb :index
end

# Só pra ficar bonitinho (copiei do cs.stackexchange.com)
get('/favicon.ico') { File.read(File.join('favicon.ico')) }
