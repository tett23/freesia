#coding: utf-8

class Notebook
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :slug, Slug
  property :remark, Text

  belongs_to :account, :required=>false
  has n, :journals

  validates_with_method :check_uniqueness_account_and_slug

  def self.list(account_id, options={})
    default = {
      account_id: account_id
    }
    options = default.merge(options)

    self.all(options)
  end

  def self.detail(screen_name, slug)
    Account.first(screen_name: screen_name)

    first(
      account_id: account_id,
      slug: slug
    )
  end

  private
  def check_uniqueness_account_and_slug
    notebook = Notebook.first(
      account_id: self.account_id,
      slug: self.slug
    )

    return true if notebook.nil?

    [false, "識別子に#{self.slug}を持つノートブックがすでにあります"]
  end
end
