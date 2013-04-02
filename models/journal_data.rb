class Journal
  include DataMapper::Resource

  property :id, Serial
  property :data, Object

  belongs_to :journal
  belongs_to :dataset
  belongs_to :data_column
end
