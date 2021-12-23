require 'rails_helper'

RSpec.describe 'the astronaut index page' do
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
    visit '/astronauts'
  end

  it 'lists all astronauts and their attributes' do
    expect(page).to have_content(@spaceman1.name)
    expect(page).to have_content(@spaceman1.age)
    expect(page).to have_content(@spaceman1.job)

    expect(page).to have_content(@spaceman2.name)
    expect(page).to have_content(@spaceman2.age)
    expect(page).to have_content(@spaceman2.job)

    expect(page).to have_content(@spaceman3.name)
    expect(page).to have_content(@spaceman3.age)
    expect(page).to have_content(@spaceman3.job)
  end

  it 'shows average age of all astronauts' do
    expect(page).to have_content("Average age: 32")
  end

  it 'shows missions for each astronaut in alphabetical order' do
    within("#astronaut-#{@spaceman1.id}") do
      expect(page).to have_content(@mission1.title)
      expect(page).to have_content(@mission2.title)
      expect(@mission1.title).to appear_before(@mission2.title)
    end
    within("#astronaut-#{@spaceman2.id}") do
      expect(page).to have_content(@mission2.title)
      expect(page).to have_content(@mission3.title)
      expect(@mission3.title).to appear_before(@mission2.title)
    end
    within("#astronaut-#{@spaceman3.id}") do
      expect(page).to have_content(@mission1.title)
      expect(page).to have_content(@mission3.title)
      expect(@mission3.title).to appear_before(@mission1.title)
    end
  end

  it 'shows each astronaut total time in space' do
    within("#astronaut-#{@spaceman1.id}") do
      expect(page).to have_content("Total time in space: 723 days")
    end
    within("#astronaut-#{@spaceman2.id}") do
      expect(page).to have_content("Total time in space: 317 days")
    end
    within("#astronaut-#{@spaceman3.id}") do
      expect(page).to have_content("Total time in space: 558 days")
    end
  end
end
