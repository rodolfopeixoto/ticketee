require 'rails_helper'

RSpec.feature 'Users can create new projects' do
  scenario do
    visit '/'

    click_link 'New Project'

    fill_in 'Name', with: Faker::Name.name 
    fill_in 'Description', with: Faker::Lorem.paragraph(2)
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'
  end
end