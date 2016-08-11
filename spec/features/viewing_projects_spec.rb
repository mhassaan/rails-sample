require "rails_helper"

RSpec.feature "Users can view projects" do
  scenario "with the project details" do
    project = FactoryGirl.create (:project)
    visit '/'
    click_link "Metro Project"
    expect(page.current_url).to eq project_url(project)
  end
end
