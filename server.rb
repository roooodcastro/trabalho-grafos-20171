require 'sinatra' # Sinatra web framework
require_relative 'autoload' # Actual program classes and modules

set :public_folder, 'public'

get '/' do
  @graph = Graph.create_random_graph(50)
  erb :index
end

# Só pra ficar bonitinho (copiei do cs.stackexchange.com)
get('/favicon.ico') { File.read(File.join('favicon.ico')) }
