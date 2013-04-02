class Notebook
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :slug, Slug
  property :remark, Text

  belongs_to :account, :required=>false
  has n, :journals

  def self.list(account_id, options={})
    default = {
      account_id: account_id
    }
    options = default.merge(options)

    self.all(options)
  end
end
