require 'rails_helper'
RSpec.feature "Users can view tickets" do
  before do
    metro = FactoryGirl.create(:project,name: 'Metro Train')
    FactoryGirl.create(:ticket,project: metro,name: 'Ticket To Mars', description: 'Is this really gona come true?')
    metro = FactoryGirl.create(:project,name: 'Orange Train')
    FactoryGirl.create(:ticket,project: metro,name: 'Ticket To Venus', description: 'Is this really gona come true?')
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
