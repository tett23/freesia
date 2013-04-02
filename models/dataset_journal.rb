class DatasetJournal
  include DataMapper::Resource

  property :id, Serial

  belongs_to :dataset
  belongs_to :journal
end
