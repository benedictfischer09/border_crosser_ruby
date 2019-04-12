module BorderCrosser
  module Instruments
    class SidekiqServerMiddleware
      def call(worker, msg, queue)
        Store.set worker["border_crosser"]
        yield
      ensure
        Store.flush!
      end
    end
  end
end
