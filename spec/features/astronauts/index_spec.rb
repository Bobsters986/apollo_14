require 'rails_helper'

RSpec.describe 'Astronaut index page', type: :feature do
  describe 'as a visitor' do
    describe 'when I visit /astronauts' do
      let!(:astronaut_1) { Astronaut.create!(name: 'Buzz Lightyear', age: 30, job: 'Space Ranger') }
      let!(:astronaut_2) { Astronaut.create!(name: 'Master Chief', age: 117, job: 'Spartan Super Soldier') }

      # before do
      #   mission_1 = astronaut_1.missions.create!(title: 'Apollo 13', time_in_space: 126)
      #   mission_2 = astronaut_1.missions.create!(title: 'Capricorn 2', time_in_space: 99)
      #   mission_3 = astronaut_2.missions.create!(title: 'Pisces 26', time_in_space: 130)
      #   mission_4 = astronaut_2.missions.create!(title: 'Aeries 9', time_in_space: 85)
      # end

      it 'I see a list of astronauts and their attribures' do
        visit '/astronauts'

        expect(page).to have_content("All Astronauts")
        within "div#astronaut_info" do
          expect(page).to have_content("Name: #{astronaut_1.name}")
          expect(page).to have_content("Age: #{astronaut_1.age}")
          expect(page).to have_content("Job: #{astronaut_1.job}")
          expect(page).to have_content("Name: #{astronaut_2.name}")
          expect(page).to have_content("Age: #{astronaut_2.age}")
          expect(page).to have_content("Job: #{astronaut_2.job}")
        end
      end

      it 'I see the average age of all astronauts' do
        astronaut_3 = Astronaut.create!(name: 'Neil Legstrong', age: 40, job: 'Aging Space Pirate')

        visit '/astronauts'
        # save_and_open_page
        expect(page).to have_content("Average Age: 62.33")
      end

      it 'shows a list of all of an astronauts mission names in alphabetical order' do
        mission_1 = astronaut_1.missions.create!(title: 'Capricorn 2', time_in_space: 99)
        mission_2 = astronaut_1.missions.create!(title: 'Apollo 13', time_in_space: 126)
        mission_3 = astronaut_2.missions.create!(title: 'Pisces 26', time_in_space: 130)
        mission_4 = astronaut_2.missions.create!(title: 'Aeries 9', time_in_space: 85)

        visit '/astronauts'

        within "div#astronaut_info" do
          save_and_open_page
          expect(page).to have_content("Missions: '#{mission_2.title}' '#{mission_1.title}'")
          expect(page).to have_content("Missions: '#{mission_4.title}' '#{mission_3.title}'")
        end
      end
    end
  end
end