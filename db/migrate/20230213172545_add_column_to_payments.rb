class AddColumnToPayments < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :name, :string
    add_column :payments, :amount, :bigint
  end
end
