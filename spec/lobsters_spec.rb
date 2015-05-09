require './lobsters'

describe Lobsters::Api do
  let(:api) { Lobsters::Api.new }
  
  it "can get the frontpage" do
    resp = JSON.parse(api.frontpage)['results']
    expect(resp.count).to eq 25
  end

  it "can get the most recent stories" do
    resp = JSON.parse(api.recent)['results']
    expect(resp.count).to eq 25
  end
end

