class API::EventsController < ApplicationController

  before_filter :set_access_control_headers
  skip_before_action :verify_authenticity_token

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])

    if !registered_application
      render json: "Unregistered application", status: :unprocessable_entity
    else
      @event = registered_application.events.new(event_params)
      if @event.save
        render json: @event, status: :created
      else
        render @event.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def event_params
    Rails.logger.info "\n\nparams: #{params}\n\n"
    params.require(:event).permit(:name)
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Origin, Content-Type'
  end
end