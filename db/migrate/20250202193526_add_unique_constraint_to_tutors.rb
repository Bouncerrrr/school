class AddUniqueConstraintToTutors < ActiveRecord::Migration[7.1]
  def change
    add_index :tutors, [:name, :surname, :tutor_specialization], unique: true, name: 'unique_tutor_subject_index'
  end
end
