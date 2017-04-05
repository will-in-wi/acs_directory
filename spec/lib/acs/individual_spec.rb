require 'spec_helper'

# These are pending since they presently depend on the data you use.
# TODO: Set up webmock to return mocked data in order to actually test.

describe ACS::Individual do
  describe '.find' do

    before { stub_request(:get, "https://secure.accessacs.com/api_accessacs_mobile/v2/123456/individuals/2").
             to_return(:status => 200, :body => IO.read(Rails.root.join('spec', 'fixtures', 'individuals', 'person1.json')), :headers => { 'Content-Type' => 'application/json; charset=utf-8' }) }

    it 'works in best case' do
      i = ACS::Individual.find 2
      expect(i.last_name).to eql('Doe')
      expect(i.indv_id).to eql(2)
      expect(i.prim_family).to eql(1001)
    end
  end

  describe '.where' do
    it 'retrieves every record' do
      pending
      WebMock.allow_net_connect!
      i = ACS::Individual.all
      expect(i.size).to eq(2400)
    end

    it 'works with query' do
      pending
      WebMock.allow_net_connect!
      i = ACS::Individual.where 'William'
      expect(i.size).to eq(15)
    end
  end
end
