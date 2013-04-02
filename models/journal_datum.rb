class JournalDatum
  include DataMapper::Resource

  property :id, Serial
  property :value, Object

  belongs_to :journal
  belongs_to :dataset
  belongs_to :data_column
end
