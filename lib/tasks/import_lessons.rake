namespace :db do
    desc "Import lessons data from JSON file"
    task import_lessons: :environment do
      file_path = Rails.root.join('db', 'imported_data', 'lessons.json')
      
      lesson_data = JSON.parse(File.read(file_path))
      
      lesson_data.each do |lesson|
        Lesson.create!(
            tutor_id: lesson["tutor_id"],
            lesson_date: lesson["lesson_date"]
        )
      end
  
      puts "Successfully imported #{lesson_data.size} lessons into the lessons table."
    end
  end