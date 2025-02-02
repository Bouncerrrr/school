class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.references :tutor, null: false, foreign_key: { to_table: :tutors }
      t.date :lesson_date, null: false 
      
      t.timestamps
    end
  end
end
