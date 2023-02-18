require 'rails_helper'

RSpec.describe 'Astronaut index page', type: :feature do
  describe 'as a visitor' do
    describe 'when I visit /astronauts' do
      let!(:astronaut_1) { Astronaut.create!(name: 'Buzz Lightyear', age: 30, job: 'Space Ranger') }
      let!(:astronaut_2) { Astronaut.create!(name: 'Master Chief', age: 117, job: 'Spartan Super Soldier') }

      it 'I see a list of astronauts and their attribures' do
        visit '/astronauts'
        save_and_open_page
        expect(page).to have_content("Name: #{astronaut_1.name}")
        expect(page).to have_content("Age: #{astronaut_1.age}")
        expect(page).to have_content("Job: #{astronaut_1.job}")
        expect(page).to have_content("Name: #{astronaut_2.name}")
        expect(page).to have_content("Age: #{astronaut_2.age}")
        expect(page).to have_content("Job: #{astronaut_2.job}")
      end
    end
  end
end