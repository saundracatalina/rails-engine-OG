class UpdateInvoicesDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default( :invoices, :status, from: "0", to: false )
  end
end
