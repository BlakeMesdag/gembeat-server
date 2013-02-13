require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, :domain => 'jadedpixel.com', :name => 'google'
end