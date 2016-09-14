require 'rails_helper'
require 'support/authorization_helpers'
RSpec.feature "Users can create new tickets" do
  let(:user){FactoryGirl.create(:user,:admin)}
  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: 'Internet Explorer')
    assign_role!(user,:viewer,project)
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Take it easy Charlie!!"
    fill_in "Description", with: "We gona burn charlie :)"
    click_button "Create Ticket"
    expect(page).to have_content "Ticket has been created."
    within('#ticket') do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "with an attachment" do
     fill_in "Name", with: 'Add documentation for blink tag'
     fill_in "Description", with: 'Blink tag has speed attribute'
     attach_file "File", "spec/fixtures/speed.txt"
     click_button "Create Ticket"
     within('#ticket') do
       expect(page).to have_content "speed.txt"
     end
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
