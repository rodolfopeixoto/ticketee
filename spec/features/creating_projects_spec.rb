require 'rails_helper'

RSpec.feature 'Users can create new projects' do
  scenario do
    name = 'Rodolfo' # Faker::Name.name
    visit '/'

    click_link 'New Project'

    fill_in 'Name', with: name 
    fill_in 'Description', with: Faker::Lorem.paragraph(2)
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'

    project = Project.find_by(name: name)
    expect(page.current_url).to eq project_url(project)

    title = "#{project.name} - Projects - Ticketee"
    expect(page).to have_title title
  end
end