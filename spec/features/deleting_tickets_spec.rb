require'rails_helper'
RSpec.feature "User can delete tickets" do
  let(:author){FactoryGirl.create(:user)}
  let(:project){FactoryGirl.create(:project)}
  let(:ticket) do
    FactoryGirl.create(:ticket, project: project, author: author)
  end

  before do
    visit project_ticket_path(project,ticket)
  end

  scenario "successfully" do
    click_link "Delete Ticket"
    expect(page.current_url).to eq project_url(project)
    expect(page).to have_content "Ticket has been deleted."
  end
end
