class Item < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.paginate(per_page, page)
    default = 20
    items_per_page = (per_page || default).to_i
    page_num = ((page || 1).to_i)-1

    limit(items_per_page).offset(items_per_page * page_num)
  end
end
