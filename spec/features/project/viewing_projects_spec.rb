require 'rails_helper'

RSpec.feature 'Users can view projects' do
  scenario 'with the project detrails' do
    project = create(:project, name: Faker::Name.name)

    visit '/'

    click_link project.name

    expect(page.current_url).to eq project_url(project)
  end
end