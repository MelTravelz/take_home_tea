class CreateTeaTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :tea_types do |t|
      t.string :title
      t.string :description
      t.integer :temperature_F
      t.string :brew_time_minutes

      t.timestamps
    end
  end
end
