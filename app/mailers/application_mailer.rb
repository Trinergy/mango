class ApplicationMailer < ActionMailer::Base
  default from: "admin@rotten_mangoes.com"
  layout 'mailer'
end
