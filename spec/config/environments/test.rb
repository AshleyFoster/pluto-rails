Rails.application.configure do
  config.action_mailer.delivery_method = :test
end
config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
