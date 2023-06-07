class CreateUserSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
