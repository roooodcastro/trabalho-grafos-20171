require 'sinatra' # Sinatra web framework
require_relative 'autoload' # Actual program classes and modules

get '/' do
  graph = Graph.create_random_graph(1000)
  vertices = graph.vertices.map(&:to_s).join("<br/>")
  edges = graph.edges.map(&:to_s).join(",")
  [graph, vertices, edges].join("<br/><br/>")
end

# Só pra ficar bonitinho (copiei do cs.stackexchange.com)
get('/favicon.ico') { File.read(File.join('favicon.ico')) }
