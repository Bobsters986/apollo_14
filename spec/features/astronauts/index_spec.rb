require 'rails_helper'

RSpec.describe 'Astronaut index page', type: :feature do
  describe 'as a visitor' do
    describe 'when I visit /astronauts' do
      let!(:astronaut_1) { Astronaut.create!(name: 'Buzz Lightyear', age: 30, job: 'Space Ranger') }
      let!(:astronaut_2) { Astronaut.create!(name: 'Master Chief', age: 117, job: 'Spartan Super Soldier') }
      let(:mission_1) { Mission.create!(title: 'Capricorn 2', time_in_space: 99) }
      let(:mission_2) { Mission.create!(title: 'Apollo 13', time_in_space: 126) }
      let(:mission_3) { Mission.create!(title: 'Pisces 26', time_in_space: 130) }
      let(:mission_4) { Mission.create!(title: 'Aeries 9', time_in_space: 85) }

      before do
          AstronautMission.create!(astronaut: astronaut_1, mission: mission_1)
          AstronautMission.create!(astronaut: astronaut_1, mission: mission_2)
          AstronautMission.create!(astronaut: astronaut_2, mission: mission_3)
          AstronautMission.create!(astronaut: astronaut_2, mission: mission_4)
      end

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

        expect(page).to have_content("Average Age: 62.33")
      end

      it 'shows a list of all of an astronauts mission names in alphabetical order' do
        visit '/astronauts'

        within "div#astronaut_info" do
          
          expect(page).to have_content("Missions: '#{mission_2.title}' '#{mission_1.title}'")
          expect(page).to have_content("Missions: '#{mission_4.title}' '#{mission_3.title}'")
        end
      end

      it 'shows each astronauts total time in space' do
        visit '/astronauts'

        within "div#astronaut_info" do
          expect(page).to have_content("Total Time in Space: #{astronaut_1.total_time_in_space}")
          expect(page).to have_content("Total Time in Space: #{astronaut_2.total_time_in_space}")
        end
      end
    end
  end
end