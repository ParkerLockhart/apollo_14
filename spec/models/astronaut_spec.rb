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

  describe 'Class methods' do
    before(:each) do
      @spaceman1 = Astronaut.create!(name: "Jim", age: 44, job: "commander")
      @spaceman2 = Astronaut.create!(name: "Tre", age: 24, job: "engineer")
      @spaceman3 = Astronaut.create!(name: "Jessica", age: 28, job: "medical officer")
    end
    describe '#average_age' do
      it 'returns average age' do
        expect(Astronaut.average_age).to eq(32)
      end
    end
  end

  describe 'Instance methods' do
    before(:each) do
      @spaceman1 = Astronaut.create!(name: "Jim", age: 44, job: "commander")
      @spaceman2 = Astronaut.create!(name: "Tre", age: 24, job: "engineer")
      @spaceman3 = Astronaut.create!(name: "Jessica", age: 28, job: "medical officer")
      @mission1 = Mission.create!(title: "Noodle Mission", time_in_space: 482)
      @mission2 = Mission.create!(title: "Nyan Cat", time_in_space: 241)
      @mission3 = Mission.create!(title: "Blackhole Sun", time_in_space: 76)

      @spaceman1.missions << @mission1
      @spaceman1.missions << @mission2
      @spaceman2.missions << @mission2
      @spaceman2.missions << @mission3
      @spaceman3.missions << @mission1
      @spaceman3.missions << @mission3
    end

    describe '#alpha_missions' do
      it 'returns all missions for an astronaut in alphabetical order' do
        expect(@spaceman2.alpha_missions).to eq([@mission3, @mission2])
      end
    end

    describe '#total_time' do
      it 'returns total time in space for astronaut missions' do
        expect(@spaceman2.total_time).to eq(317)
      end
    end
  end 
end
