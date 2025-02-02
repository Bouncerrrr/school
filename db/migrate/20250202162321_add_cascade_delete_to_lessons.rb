class AddCascadeDeleteToLessons < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :lessons, :tutors
    add_foreign_key :lessons, :tutors, on_delete: :cascade
  end
end
