class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.string :consignment_id
      t.string :name
      t.string :good_type, index: true
      t.string :source
      t.string :destination
      t.datetime :entry_date, index: true
      t.datetime :exit_date, index: true

      t.timestamps
    end
    add_index :goods, :consignment_id, unique: true
  end
end
