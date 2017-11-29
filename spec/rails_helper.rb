ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'database_cleaner'
require 'capybara/rails'
require 'support/factory_girl'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Dir["#{Rails.root}/app/models/**/*.rb"].each do |model|
  load model
end

ActiveRecord::Migration.maintain_test_schema!
ActiveJob::Base.queue_adapter = :test

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  include ActiveJob::TestHelper
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  # Deprecation Warning
  config.after(:each) { Warden.test_reset! }
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Capybara::DSL
  config.include Warden::Test::Helpers

  config.before(:suite) do
    Webpacker.compile
  end
end

