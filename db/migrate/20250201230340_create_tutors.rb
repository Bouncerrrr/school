class CreateTutors < ActiveRecord::Migration[7.1]
  def change
    create_table :tutors do |t|
      t.string :name, null: false, limit: 40
      t.string :surname, null: false, limit: 40
      t.string :tutor_specialization, null: false, limit: 40
      t.integer :hourly_price, null: false, limit: 4
      t.timestamps
    end
  end
end
