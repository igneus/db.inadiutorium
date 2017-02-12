# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/home', to: 'home#index'

root to: 'home#index'

get '/zpevy/zanr', to: 'pieces#genres', as: :genres
get '/zpevy/zanr/:genre', to: 'pieces#by_genre', as: :genre
get '/zpevy/modus', to: 'pieces#modes', as: :modes
get '/zpevy/modus/:mode', to: 'pieces#by_mode', as: :mode
resources :zpevy, controller: :pieces, only: %i(index show)
