require 'minitest/autorun'
require '../validators/format_validator'

class TestFormatValidator < Minitest::Test
  def setup
    @subject = OpenStruct.new(email: '')
  end

  def test_should_be_valid_format
    @subject.email = 'lorem@ipsum.com'

    validator = FormatValidator.new(@subject, :email, /.+@.+\..+/)

    assert validator.valid?
  end

  def test_should_be_invalid_format
    @subject.email = 'lorem#ipsum.com'

    validator = FormatValidator.new(@subject, :email, /.+@.+\..+/)

    assert_raises(
      FormatValidator::Error,
      "Wrong format for email value, should be `/.+@.+\..+/`"
    ) { validator.validate! }

    refute validator.valid?
  end

  def test_raising_an_error_when_rule_is_not_regexp
    validator = FormatValidator.new(@subject, :email, %i[I am not Regexp])

    assert_raises(
      ArgumentError,
      "Format rule should be a Regexp"
    ) { validator.valid? }
  end
end
