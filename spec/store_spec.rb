require "spec_helper"

RSpec.describe BorderCrosser::Store do
  before do
    described_class.flush!
  end

  it "nil by default" do
    expect(described_class.get).to eq(nil)
  end

  it "can read its writes" do
    described_class.set("abc")
    expect(described_class.get).to eq("abc")
  end

  it "flushes" do
    described_class.set("abc")
    described_class.flush!
    expect(described_class.get).to eq(nil)
  end
end
