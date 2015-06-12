CarrierWave.configure do |config|
  if Rails.env.test? or Rails.env.cucumber?
    config.enable_processing = false
  end
  config.storage = :file
  config.permissions = 0600
end
