Rails.application.routes.draw do

  mount MessengerPlatform::Engine, at: "/hookie_hook"

end
