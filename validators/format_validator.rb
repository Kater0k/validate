class FormatValidator < BaseValidator
  class Error < ArgumentError
  end

  private

  def validate
    unless @rule.is_a?(Regexp)
      raise ArgumentError, 'Format rule should be a Regexp'
    end

    @valid = !(@value =~ @rule).nil?
  end

  def exception
    Error.new(
      "Wrong format for #{@attr} value, should be `#{@rule.inspect}`"
    )
  end
end
