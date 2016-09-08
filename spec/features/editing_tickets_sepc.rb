require 'rails_helper'

RSpec.feature "User can edit exisiting tickets" do
  let(:author){FactoryGirl.create(:user)}
  let(:project){FactoryGirl.create(:project)}
  let(:ticket) do
    FactoryGirl.create(:ticket,project: project, author: author)
  end

  before do
    visit project_ticket_path(project,ticket)
    click_link "Edit Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: 'Make it two folded.'
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has been updated."
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ''
    click_button "Update Ticket"
    expect(page).to have_content "Ticket has not been updated."
  end
end
