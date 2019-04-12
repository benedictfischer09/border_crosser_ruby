require "rack"

module BorderCrosser
  module Instruments
    class RackMiddleware
      def initialize(app)
        @app = app
      end

      def call(env)
        dup.call!(env)
      end

      def call!(env)
        req = Rack::Request.new(env)

        id = req.get_header("X-Border-Crosser") || IdGenerator.generate
        Store.set(id)
        status, headers, response = @app.call(env)
        [status, headers, response]
      ensure
        Store.flush!
      end
    end
  end
end
