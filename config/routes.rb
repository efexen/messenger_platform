MessengerPlatform::Engine.routes.draw do

  get "/", to: 'webhook#subscribe'
  post "/", to: 'webhook#message'

end
