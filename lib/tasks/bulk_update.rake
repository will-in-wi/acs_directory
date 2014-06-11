namespace 'acs' do
  desc 'Mass check against upstream'
  task bulk_update: :environment do
    individuals = ACS::Individual.all
    Indexer::Individual.import_all!(individuals)
  end
end
