require 'rails_helper'

RSpec.feature "Users can see appropriate links only" do
  let(:user){FactoryGirl.create(:user)}
  let(:admin){FactoryGirl.create(:user,:admin)}
  let(:project){FactoryGirl.create(:project)}
  let(:ticket) do
    FactoryGirl.create(:ticket, project: project, author: user)
  end

  context "anonymous users" do
    scenario "can't see New Project Link" do
      visit '/'
      expect(page).not_to have_link "New Project"
    end
  end

  context "non-admin users" do
    before {login_as(user)}
    scenario "can't see New Project Link" do
      visit "/"
      expect(page).not_to have_link "New Project"
    end

    before "can't see the Edit Project link" do
      visit project_path(project)
      expect(page).not_to have_link "Edit Project"
    end
  end

  context "admin users" do
    before {login_as(admin)}
    scenario "can see New Project Link" do
      visit "/"
      expect(page).to have_link "New Project"
    end

    before "can see the Edit Project link" do
      visit project_path(project)
      expect(page).to have_link "Edit Project"
    end
  end

  context "non-admin users (project viewers)" do
    before{login_as(user)}
    scenario "cannot see the Edit Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).not_to have_link "Edit Ticket"
    end
  end

  context "admin users" do
    before{login_as(admin)}
    scenario "can see the Edit Ticket link" do
      visit project_ticket_path(project, ticket)
      expect(page).to have_link "Edit Ticket"
    end
  end


  # context "admin users" do
  #   before {login_as(admin)}
  #   scenario "can see Delete Project Link" do
  #     visit project_path(project)
  #     expect(page).to have_link "Delete Project"
  #   end
  # end

end
