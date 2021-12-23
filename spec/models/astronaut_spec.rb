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

    it 'returns average age' do
      expect(Astronaut.average_age).to eq(32)
    end
  end
end
