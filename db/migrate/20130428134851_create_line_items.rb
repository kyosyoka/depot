class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id, :null => false, :options =>
         "CONSTRAINT fk_line_item_products REFERENCES products(id)"
      t.integer :order_id, :null => false, :options =>
         "CINSTRAINT fk_line_item_orders REFERENCES orders(id)"
      t.integer :quantity, :null => false
      t.decimal :total_price, :null => false, :pricision => 8, :scale => 2

      t.timestamps
    end
  end
  def self.down
    drop_table :line_items
  end
end
