class CreateSelfEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :self_evaluations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :evaluation_item, null: false, foreign_key: true
      t.integer :score, null: false
      t.text :comment
      t.timestamps
    end
  end
end
