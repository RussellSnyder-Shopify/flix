RSpec.configure do |_config|
  Capybara.asset_host = 'http://localhost:3000/'
  Capybara.always_include_port
  Capybara.server = :puma
end
