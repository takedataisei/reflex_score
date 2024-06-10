class CreateEvaluationItems < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluation_items do |t|
      t.references :community, null: false, foreign_key: true
      t.string :name, null: false
      t.timestamps
    end
  end
end
