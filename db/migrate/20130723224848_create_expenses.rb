class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :category
      t.decimal :amount, precision: 8, scale: 2
      t.references :user, index: true

      t.timestamps
    end
  end
end
