class TypeValidator < BaseValidator
  class Error < ArgumentError
  end

  private

  def validate
    unless @rule.is_a?(Class)
      raise ArgumentError, 'Type rule should be a Class'
    end

    @valid = @value.is_a?(@rule)
  end

  def exception
    Error.new(
      "The value of #{@attr} should be istance of `#{@rule}`"
    )
  end
end
