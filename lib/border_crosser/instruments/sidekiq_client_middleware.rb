module BorderCrosser
  module Instruments
    class SidekiqClientMiddleware
      def call(worker_class, job, queue, redis_pool)
        job['border_crosser'] = Store.get
        yield
      end
    end
  end
end
