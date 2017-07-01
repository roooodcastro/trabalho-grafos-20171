require 'sinatra'            # Sinatra web framework
require 'pry'                # Debugging tool
require_relative 'autoload'  # Actual program classes and modules

set :public_folder, 'public' # Public folder to get 'application.js' from

get '/' do
  # Gets the number of vertices from params, with 50 as default
  # Limits the absolute maximum number to 1000, to prevent eternal load times
  num_vertices = [(params[:n] || 50).to_i, 1000].min

  # Creates a random graph
  graph = Graph.create_random_graph(num_vertices)

  # Runs the Dijkstra algorithm, which directly modifies the graph, setting each
  # vertex's previous and distance information.
  @dijkstra = Dijkstra.new(graph)
  @dijkstra.run

  # Render the index template
  erb :index
end

# Só pra ficar bonitinho (copiei do cs.stackexchange.com)
get('/favicon.ico') { File.read(File.join('favicon.ico')) }
