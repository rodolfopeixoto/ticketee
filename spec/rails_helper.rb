require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'faker'
require 'pry'
require 'pundit/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |file| require file }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers, type: :feature
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.after(type: :feature) { Warden.test_reset! }
  
end
