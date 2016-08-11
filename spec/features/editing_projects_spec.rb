require 'rails_helper'

RSpec.feature "User can edit existing project" do
  before do
    FactoryGirl.create(:project)
    visit "/"
    click_link "Metro Project"
    click_link "Edit Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with:  "Metro Project Beta"
    click_button "Update Project"
    expect(page).to have_content "Project has been updated."
    expect(page).to have_content "Metro Project Beta"
  end

  scenario "when providing invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"   
    expect(page).to have_content "Project has not been updated."
  end

end
