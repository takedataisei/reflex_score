class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name, null: false, unique: true
      t.string :password_digest, null: false
      t.text :description
      t.integer :admin_id, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
