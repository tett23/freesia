class Journal
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :slug, Slug
  property :remark, Text

  belongs_to :account, :required=>false
  has n, :journals
end
