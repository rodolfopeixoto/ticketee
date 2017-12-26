require 'rails_helper'

RSpec.feature 'Users can create new projects' do
 
  before do
   visit '/'
   click_link 'New Project'
  end
  
  scenario 'with valid attributes' do
    
    name = 'Rodolfo' # Faker::Name.name

    fill_in 'Name', with: name 
    fill_in 'Description', with: Faker::Lorem.paragraph(2)
    click_button 'Create Project'

    expect(page).to have_content 'Project has been created.'

    project = Project.find_by(name: name)
    expect(page.current_url).to eq project_url(project)

    title = "#{project.name} - Projects - Ticketee"
    expect(page).to have_title title
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Project'

    expect(page).to have_content 'Project has not been created.'
    expect(page).to have_content "Name can't be blank"
  end
end