class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,             null: false, foreign_key: true
      t.string     :name,             null: false
      t.string     :tag_name
      t.text       :detail,           null: false
      t.integer    :condition_id,     null: false
      t.integer    :fee_burdened_id,  null: false
      t.integer    :prefecture_id,    null: false
      t.integer    :shipping_date_id, null: false
      t.integer    :category_id,      null: false
      t.integer    :price,            null: false
      t.timestamps
    end
  end
end
