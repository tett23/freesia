class Journal
  include DataMapper::Resource

  property :id, Serial

  belongs_to :account, :required=>false
  has n, :datasets, :through=>Resource
  has n, :journal_data
end
