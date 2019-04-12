require "spec_helper"

RSpec.describe BorderCrosser::IdGenerator do
  it "generates something unique every time" do
    ids = 50.times.map do
      described_class.generate
    end
    expect(ids.uniq.size).to eq(50)
  end

  it "can configure the size of the hex" do
    id = described_class.generate(5)
    expect(id.length).to eq(5)
    id = described_class.generate(10)
    expect(id.length).to eq(10)
  end
end
