# frozen_string_literal: true

# This is the base class for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> { Rails.env.test? && request.format.json? }
end
