require 'rails_helper'

RSpec.feature "Users can see appropriate links only" do
  let(:user){FactoryGirl.create(:user)}
  let(:admin){FactoryGirl.create(:user,:admin)}
  let(:project){FactoryGirl.create(:project)}

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
  end

  context "admin users" do
    before {login_as(admin)}
    scenario "can see New Project Link" do
      visit "/"
      expect(page).to have_link "New Project"
    end
  end


  context "anonymous users" do
    scenario "can't see Delete Project Link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
  end

  context "non-admin users" do
    before {login_as(user)}
    scenario "can't see Delete Project Link" do
      visit project_path(project)
      expect(page).not_to have_link "Delete Project"
    end
  end

  context "admin users" do
    before {login_as(admin)}
    scenario "can see Delete Project Link" do
      visit project_path(project)
      expect(page).to have_link "Delete Project"
    end
  end
end
