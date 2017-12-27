require 'rails_helper'

RSpec.feature 'Users can delete projects' do

  before do
    user = create(:user, :admin)
    login_as(user)
  end

  scenario 'successfully' do
    project = create(:project)

    visit '/'

    click_link project.name
    click_link 'Delete Project'

    expect(page).to have_content 'Project has been deleted.'
    expect(page.current_url).to eq projects_url
    expect(page).to have_no_content project.name
  end
end