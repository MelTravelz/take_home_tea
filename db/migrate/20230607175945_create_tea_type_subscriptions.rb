class CreateTeaTypeSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :tea_type_subscriptions do |t|
      t.references :subscription, null: false, foreign_key: true
      t.references :tea_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
