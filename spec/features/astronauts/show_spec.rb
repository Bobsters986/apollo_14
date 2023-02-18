require 'rails_helper'

RSpec.describe 'Astronaut show page', type: :feature do
  describe 'as a visitor' do
    describe 'when I visit /astronauts/:id' do
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

      it "I see the astronaut's name and mission's they've been on" do
        visit "/astronauts/#{astronaut_1.id}"
        # save_and_open_page
        expect(page).to have_content("Astronaut: #{astronaut_1.name}")

        within "p#missions" do
          expect(page).to have_content("Missions: '#{mission_2.title}' '#{mission_1.title}'")
        end
      end
    end
  end
end