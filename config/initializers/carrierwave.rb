require 'carrierwave/orm/activerecord'

# unless ENV['AWS_ACCESS_KEY_ID'].blank?
  CarrierWave.configure do |config|
    # config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      :provider               => 'AWS',                        # required
      :aws_access_key_id      => 'AKIAJNYZSV7A47UHWE7A',                        # required
      :aws_secret_access_key  => '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',                         # required
      :region                 => 'us-west-2'
    }
    
    config.storage        = :fog
    config.fog_directory  = 'mango1221'                     # required
    config.fog_public     = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'} 
  end
# end