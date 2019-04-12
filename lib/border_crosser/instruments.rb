module BorderCrosser
  module Instruments
    autoload :RackMiddleware, "border_crosser/instruments/rack_middleware"
    autoload :SidekiqClientMiddleware, "border_crosser/instruments/sidekiq_client_middleware"
    autoload :SidekiqServerMiddleware, "border_crosser/instruments/sidekiq_server_middleware"
  end
end
