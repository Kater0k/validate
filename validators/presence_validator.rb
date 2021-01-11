class PresenceValidator < BaseValidator
  class Error < ArgumentError
  end

  private

  def validate
    if !(@rule.is_a?(TrueClass) || @rule.is_a?(FalseClass))
      raise ArgumentError, 'Presence rule should be `true` or `false`'
    end

    @valid =
      @rule == (!@value.is_a?(NilClass) && (@value.is_a?(String) && !@value.empty?)) # maybe `!@value.strip.empty?` would be better
  end

  def exception
    message =
      if @rule
        "The value for #{@attr}, can't be `nil` or empty string"
      else
        "The value for #{@attr}, should be nil or empty string"
      end

    Error.new(message)
  end
end
