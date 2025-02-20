class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  after_action :flash_to_turbo_stream

  private

  def flash_to_turbo_stream
    return unless request.format.turbo_stream?
    turbo_stream.append("flash", partial: "shared/flash")
  end
end
