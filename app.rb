require_relative 'date_service'
require 'rack'

class App
  attr_reader :status, :body

  def call(env)
    request = Rack::Request.new(env)
    return make_response(404, 'Page not found') if request_time? == false
    format_date = DateService.new(request.params['format'])
    format_date.format_params
    if format_date.valid?
      make_response(200, format_date.formatted_time)
    else
      make_response(400, format_date.invalid_formats)
    end
  end

  private

  def request_time?
    request.get? && request.path == '/time' && request.params['format']
  end

  def make_response(status, body)
    Rack::Response.new(body, status, {'Content-Type' => 'text/plain'}).finish
  end
end