class DataColumn
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :type, Enum[:string, :text, :integer, :float, :image, :video, :audio]
  property :remark, Text

  belongs_to :account, :required=>false
end
