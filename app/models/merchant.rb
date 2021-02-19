class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.paginate(per_page, page)
    default = 20
    merchants_per_page = (per_page || default).to_i
    page_num = ((page || 1).to_i)-1

    limit(merchants_per_page).offset(merchants_per_page * page_num)
  end

  def self.merch_search(name_key, search_fragment)
    find_by("LOWER(#{name_key}) LIKE LOWER('%#{search_fragment}%')")
  end

  def self.top_merch_revenue(limit)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: { result: 'success' }, invoices: { status: 'shipped' })
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group(:id)
    .order('total_revenue DESC')
    .limit(limit)
  end
end
