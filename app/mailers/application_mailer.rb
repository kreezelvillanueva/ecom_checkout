# frozen_string_literal: true

# This is the base class for all mailers
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
