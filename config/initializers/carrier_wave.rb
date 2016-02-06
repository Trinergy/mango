require 'carrierwave/orm/activerecord'
unless ENV['AKIAJV7P64RX5PVI6ZIQ'].blank?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3 should be made available through an Environment variable.
      # For local installations, export the env variable through the shell OR
      # if using Passenger, set an Apache environment variable.
      #
      # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
      #
      # $ heroku config:add S3_KEY=AKIAJV7P64RX5PVI6ZIQ S3_SECRET=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 S3_REGION=s3-us-west-2 S3_ASSET_URL=https://s3-us-west-2.amazonaws.com S3_BUCKET_NAME=mango1221/mango-images

      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJV7P64RX5PVI6ZIQ'],
      :aws_secret_access_key => ENV['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'],
      :region                => ENV['s3-us-west-2']
    }

    # For testing, upload files to local `tmp` folder.
    if Rails.env.test? || Rails.env.cucumber?
      config.storage = :file
      config.enable_processing = false
      config.root = "#{Rails.root}/tmp"
    else
      config.storage = :fog
    end

    config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku

    config.fog_directory    = ENV['mango1221']
    config.s3_access_policy = :public_read                          # Generate http:// urls. Defaults to :authenticated_read (https://)
    config.fog_host         = "#{ENV['https://s3-us-west-2.amazonaws.com']}/#{ENV['S3_BUCKET_NAME']}"
  end
end