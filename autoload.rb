# Helper method to load a module and all of its subclasses
def autoload_module(name)
  require_relative "lib/#{name}"
  Dir[File.join(Dir.pwd,'lib', name, '*.rb')].each { |file| require file }
end

# Loads the needed classes and modules for the program
autoload_module 'graph'
autoload_module 'f_heap'
autoload_module 'priority_queue'
autoload_module 'dijkstra'
