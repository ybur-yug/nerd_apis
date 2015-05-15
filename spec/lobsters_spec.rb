require './lib/apis'

describe Apis::Lobsters do
  let(:lobsters_api) { Apis::Lobsters.new }

  it 'can get the frontpage' do
    resp = JSON.parse(lobsters_api.frontpage(1))['results']
    expect(resp.count).to eq 25
  end

  it 'can get the most recent stories' do
    resp = JSON.parse(lobsters_api.recent(1))['results']
    expect(resp.count).to eq 25
  end
end

describe Apis::Proggit do
  let(:proggit_api) { Apis::Proggit.new }

  it 'can get the frontpage' do
    resp = JSON.parse(proggit_api.frontpage)['results']
    expect(resp.count).to eq 25
  end
end

describe Apis::DataTau do
  let(:datatau_api) { Apis::DataTau.new }

  it 'can get the frontpage' do
    resp = JSON.parse(datatau_api.frontpage)
  end
end
