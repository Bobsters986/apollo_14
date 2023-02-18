require 'rails_helper'

describe Astronaut, type: :model do

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe '#class_methods' do
    let!(:astronaut_1) { Astronaut.create!(name: 'Buzz Lightyear', age: 30, job: 'Space Ranger') }
    let!(:astronaut_2) { Astronaut.create!(name: 'Master Chief', age: 117, job: 'Spartan Super Soldier') }
    let!(:astronaut_3) { Astronaut.create!(name: 'Neil Legstrong', age: 40, job: 'Aging Space Pirate') }
    
    it 'can calculate the average age of all astronauts' do
      expect(Astronaut.average_age.round(2)).to eq(62.33)
      expect(Astronaut.average_age).to_not eq(65)

      astronaut_4 = Astronaut.create!(name: 'John Johnson', age:33, job: 'Rookie Explorer')

      expect(Astronaut.average_age.round(2)).to eq(55)
    end
  end
end
