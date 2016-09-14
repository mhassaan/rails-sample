require "rails_helper"
require "support/authorization_helpers"

RSpec.feature "Users can view projects" do
  let(:user){FactoryGirl.create(:user)}
  let(:project){FactoryGirl.create(:project,name: 'On the top of world!')}

  before do
    login_as(user)
    assign_role!(user,:viewer,project)
  end
  scenario "with the project details" do
    #project = FactoryGirl.create (:project)
    visit '/'
    click_link "On the top of world!"
    expect(page.current_url).to eq project_url(project)
  end

  scenario "unless they do not have permission" do
    FactoryGirl.create(:project, name: "Hidden")
    visit "/"
    expect(page).not_to have_content "Hidden"
  end

end
