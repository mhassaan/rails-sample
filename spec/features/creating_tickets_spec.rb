require 'rails_helper'

RSpec.feature "Users can create new tickets" do
  before do
    project = FactoryGirl.create(:project, name: 'Internet Explorer')
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Take it easy Charlie!!"
  fill_in "Description", with: "We gona burn charlie :)"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has been created."
  end

  scenario "with invalid attributes" do
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has not been created."
  end

  scenario "with an invalid description" do
    fill_in "Name", with: 'Trip To Mars'
    fill_in "Description", with: 'It is.'
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end
end
