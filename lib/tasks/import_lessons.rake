namespace :db do
  desc "Import lessons data from JSON file"
  task import_lessons: :environment do
    file_path = Rails.root.join('db', 'imported_data', 'lessons.json')

    lesson_data = JSON.parse(File.read(file_path))

    lesson_data.each do |lesson|
      new_lesson = Lesson.new(
        tutor_id: lesson["tutor_id"],
        lesson_date: Date.today
      )

      if new_lesson.save(validate: false)
        new_lesson.update_column(:lesson_date, lesson["lesson_date"])
      else
        puts "Failed to import lesson for tutor_id #{lesson['tutor_id']}"
      end
    end

    puts "Successfully imported #{lesson_data.size} lessons into the lessons table."
  end
end
