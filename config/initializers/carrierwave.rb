CarrierWave.configure do |config|
  if ENV['AWS_ACCESS_KEY_ID'].present?
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory = "mathie-timelines-#{Rails.env}"
    config.storage = :fog
  else
    config.storage = :file
  end
end