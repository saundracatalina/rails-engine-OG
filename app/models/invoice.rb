class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :transactions
  has_many :items, through: :invoice_items
end
