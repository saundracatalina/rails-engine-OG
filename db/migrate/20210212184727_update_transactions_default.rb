class UpdateTransactionsDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:transactions, :result, nil)
  end
end
