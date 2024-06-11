class CreatePeerEvaluations < ActiveRecord::Migration[7.0]
  def change
    create_table :peer_evaluations do |t|
      t.references :evaluation_item, null: false, foreign_key: true
      t.bigint :evaluator_id, null: false
      t.bigint :evaluatee_id, null: false
      t.integer :score, null: false
      t.text :comment
      t.timestamps
    end

    add_foreign_key :peer_evaluations, :users, column: :evaluator_id
    add_foreign_key :peer_evaluations, :users, column: :evaluatee_id
    add_index :peer_evaluations, :evaluator_id
    add_index :peer_evaluations, :evaluatee_id
  end
end
