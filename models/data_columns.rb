class DataColumn
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :type, Enum[*DataType::TYPES]
  property :remark, Text

  belongs_to :account, :required=>false

  def self.list(account_id, options={})
    default = {
      account_id: account_id
    }
    options = default.merge(options)

    self.all(options)
  end
end
