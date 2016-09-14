require 'rails_helper'
require 'support/authorization_helpers'

RSpec.feature "User can edit existing project" do
  let(:user){FactoryGirl.create(:user)}
  let(:project){FactoryGirl.create(:project,name: 'Metro Project')}

  before do
    assign_role!(user,:manager,project)
    login_as(user)
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
