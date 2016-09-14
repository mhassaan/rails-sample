require 'rails_helper'
require 'support/authorization_helpers'
RSpec.feature "Users can view tickets" do
  before do
    author = FactoryGirl.create(:user)
    metro_project = FactoryGirl.create(:project,name: 'Metro Train')
    assign_role!(author,:viewer,metro_project)
    FactoryGirl.create(:ticket,project: metro_project,author: author,name: 'Ticket To Mars', description: 'Is this really gona come true?')
    orange_project = FactoryGirl.create(:project,name: 'Orange Train')
    FactoryGirl.create(:ticket,project: orange_project,author: author,name: 'Ticket To Venus', description: 'Is this really gona come true?')
    assign_role!(author,:viewer,orange_project)
    login_as(author)
    visit '/'
  end

  scenario "for a given project" do
    click_link "Metro Train"
    expect(page).to have_content "Ticket To Mars"
    expect(page).to_not have_content "Ticket To Venus"
    click_link "Ticket To Mars"
    within("#ticket h2") do
      expect(page).to have_content "Ticket To Mars"
    end

  end
end
