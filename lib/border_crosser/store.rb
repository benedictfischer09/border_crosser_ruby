module BorderCrosser
  class Store
    def self.get
      Thread.current.thread_variable_get(:border_crosser_id)
    end

    def self.set(id)
      Thread.current.thread_variable_set(:border_crosser_id, id)
    end

    def self.flush!
      Thread.current.thread_variable_set(:border_crosser_id, nil)
    end
  end
end
