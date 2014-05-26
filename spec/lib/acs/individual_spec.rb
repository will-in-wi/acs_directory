require 'spec_helper'

# These are pending since they presently depend on the data you use.
# TODO: Set up webmock to return mocked data in order to actually test.

describe ACS::Individual do
  describe '.find' do
    it 'works in best case' do
      pending
      WebMock.allow_net_connect!
      i = ACS::Individual.find 254
      expect(i.last_name).to eql('SomeName')
      expect(i.indv_id).to eql(254)
      expect(i.prim_family).to eql(1094)
    end
  end

  describe '.where' do
    it 'retrieves every record' do
      pending
      WebMock.allow_net_connect!
      i = ACS::Individual.all
      expect(i).to have(2400).items
    end

    it 'works with query' do
      pending
      WebMock.allow_net_connect!
      i = ACS::Individual.where 'William'
      expect(i).to have(15).items
    end
  end
end
