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

  let!(:astronaut_1) { Astronaut.create!(name: 'Buzz Lightyear', age: 30, job: 'Space Ranger') }
  let!(:astronaut_2) { Astronaut.create!(name: 'Master Chief', age: 117, job: 'Spartan Super Soldier') }
  let!(:astronaut_3) { Astronaut.create!(name: 'Neil Legstrong', age: 40, job: 'Aging Space Pirate') }

  before do
    @mission_1 = astronaut_1.missions.create!(title: 'Capricorn 2', time_in_space: 99)
    @mission_2 = astronaut_1.missions.create!(title: 'Zeta 15', time_in_space: 126)
    @mission_3 = astronaut_1.missions.create!(title: 'Apollo 13', time_in_space: 100)
    @mission_4 = astronaut_2.missions.create!(title: 'Pisces 26', time_in_space: 130)
    @mission_5 = astronaut_2.missions.create!(title: 'Aeries 9', time_in_space: 85)
    @mission_6 = astronaut_2.missions.create!(title: 'Libra 18', time_in_space: 100)
  end

  describe '#class_methods' do
    it 'can calculate the average age of all astronauts' do
      expect(Astronaut.average_age.round(2)).to eq(62.33)
      expect(Astronaut.average_age).to_not eq(65)

      astronaut_4 = Astronaut.create!(name: 'John Johnson', age:33, job: 'Rookie Explorer')

      expect(Astronaut.average_age.round(2)).to eq(55)
    end
  end

  describe '.instance_methods' do
    it 'can sort an astronauts missions alphabetically' do
      expect(astronaut_1.sort_alpha).to eq([@mission_3.title, @mission_1.title, @mission_2.title])
      expect(astronaut_2.sort_alpha).to eq([@mission_5.title, @mission_6.title, @mission_4.title])
    end

    it 'can show an astronauts total time in space' do
      expect(astronaut_1.total_time_in_space).to eq(325)
      expect(astronaut_1.total_time_in_space).to_not eq(350)
      expect(astronaut_2.total_time_in_space).to eq(315)
      expect(astronaut_2.total_time_in_space).to_not eq(275)
    end
  end
end
