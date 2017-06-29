require 'sinatra'

get '/' do
  'Hello World!'
end

# Só pra ficar bonitinho (copiei do cs.stackexchange.com)
get('/favicon.ico') { File.read(File.join('favicon.ico')) }
