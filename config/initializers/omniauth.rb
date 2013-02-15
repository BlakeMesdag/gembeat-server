require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, :domain => ENV['GOOGLE_APPS_DOMAIN'], :name => 'google'
end