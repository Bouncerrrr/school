namespace :db do
    desc "Import tutors data from JSON file"
    task import_tutors: :environment do
      file_path = Rails.root.join('db', 'imported_data', 'tutors.json')
      
      tutors_data = JSON.parse(File.read(file_path))
      
      tutors_data.each do |tutor|
        Tutor.create!(
          name: tutor["name"],
          surname: tutor["surname"],
          tutor_specialization: tutor["tutor_specialization"],
          hourly_price: tutor["hourly_price"]
        )
      end
  
      puts "Successfully imported #{tutors_data.size} tutors into the tutors table."
    end
  end