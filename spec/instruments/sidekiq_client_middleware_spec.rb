require "spec_helper"

RSpec.describe BorderCrosser::Instruments::SidekiqClientMiddleware do
  after do
    BorderCrosser::Store.flush!
  end

  it "adds the data to the job before queueing" do
    job = {}
    BorderCrosser::Store.set("abc")
    described_class.new.call(nil, job, nil, nil) {}
    expect(job["border_crosser"]).to eql("abc")
  end
end
