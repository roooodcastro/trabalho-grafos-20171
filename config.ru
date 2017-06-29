require './server'
use Rack::Deflater # Enables GZIP
run Sinatra::Application