class DateService

  FORMATS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(format_params)
    @format_params = format_params
    @formats = []
    @miss_format = []
  end

  def formatted_time
    Time.now.strftime(@options.join('-'))
  end

  def valid?
    @miss_format.empty?
  end

  def invalid_formats
    "Unknown time format #{@miss_format}"
  end

  private

  def format_params
    params = @format_params.split(',')
    params.each do |param|
      if FORMATS.key?(param.to_sym)
        @formats << FORMATS[param.to_sym]
      else
        @miss_format << param
      end
    end
  end
end