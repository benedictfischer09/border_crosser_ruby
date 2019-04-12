require "spec_helper"

RSpec.describe BorderCrosser::Instruments::SidekiqServerMiddleware do
  after do
    BorderCrosser::Store.flush!
  end

  it "parses the data from the job and hydrates the store" do
    worker = { "border_crosser" => "abc567" }
    described_class.new.call(worker, nil, nil) do
      expect(BorderCrosser::Store.get).to eq("abc567")
    end
  end

  it "flushes the store when the job is done" do
    worker = { "border_crosser" => "abc567" }
    described_class.new.call(worker, nil, nil) { }
    expect(BorderCrosser::Store.get).to be_nil
  end
end
