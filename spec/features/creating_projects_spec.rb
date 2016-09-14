require 'rails_helper'


RSpec.feature "User can create new projects" do

  before do
    login_as(FactoryGirl.create(:user,:admin))
    visit "/"
    click_link "New Project"
  end
  scenario "with valid attibutes" do
    fill_in "Name", with: "Metro Project"
    fill_in "Description", with: "First Vehivle Service"
    click_button "Create Project"

    expect(page).to have_content "Project has been created."
    project = Project.find_by(name:"Metro Project")
    expect(page.current_url).to eq project_url(project)
    title = "TRENTO BUS SERVICE"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    click_button "Create Project"
    expect(page).to have_content "Project has not been created."
    expect(page).to have_content "Name can't be blank"
  end
end
