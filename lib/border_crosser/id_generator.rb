require 'securerandom'

module BorderCrosser
  class IdGenerator
    def self.generate(desired_size = 10)
      size = desired_size / 2
      size += 1 if desired_size.odd?

      # note string length will be 2x size
      SecureRandom.hex(size).slice(0, desired_size)
    end
  end
end
