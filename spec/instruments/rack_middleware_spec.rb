require "spec_helper"

RSpec.describe BorderCrosser::Instruments::RackMiddleware do
  class App
    def call(env)
      [200, {}, BorderCrosser::Store.get]
    end
  end

  it "when the app accesses the request the store is hydrated from generator" do
    app = App.new
    env = {}
    allow(BorderCrosser::IdGenerator).to receive(:generate).and_return("123abc")
    status, headers, response = described_class.new(app).call(env)
    expect(status).to eq(200)
    expect(response).to eq("123abc")
  end

  it "when the app accesses the request the store is hydrated from headers" do
    app = App.new
    env = { "X-Border-Crosser" => "456def" }
    status, headers, response = described_class.new(app).call(env)
    expect(status).to eq(200)
    expect(response).to eq("456def")
  end

  it "when the request is over the store is flushed" do
    app = App.new
    env = {}
    described_class.new(app).call(env)
    expect(BorderCrosser::Store.get).to be_nil
  end
end
