require 'minitest/autorun'
require '../validators/presence_validator'

class TestPresenceValidator < Minitest::Test
  def setup
    @subject = OpenStruct.new(name: nil)
  end

  def test_should_be_valid_with_true_option
    @subject.name = 'lorem@ipsum.com'

    validator = PresenceValidator.new(@subject, :name, true)

    assert validator.valid?
  end

  def test_should_be_invalid_with_true_option_for_nil
    validator = PresenceValidator.new(@subject, :name, true)

    assert_raises(
      PresenceValidator::Error,
      "The value for name, can't be `nil` or empty string"
    ) { validator.validate! }

    refute validator.valid?
  end

  def test_should_be_invalid_with_true_option_for_blank_string
    @subject.name = ''

    validator = PresenceValidator.new(@subject, :name, true)

    assert_raises(
      PresenceValidator::Error,
      "The value for name, can't be `nil` or empty string"
    ) { validator.validate! }

    refute validator.valid?
  end

  def test_should_be_valid_with_false_option_for_nil
    @subject.name = nil

    validator = PresenceValidator.new(@subject, :name, false)

    assert validator.valid?
  end

  def test_should_be_valid_with_false_option_for_blank_string
    @subject.name = ''

    validator = PresenceValidator.new(@subject, :name, false)

    assert validator.valid?
  end

  def test_should_be_invalid_with_false_option_for_not_nil_and_not_blank_string_values
    @subject.name = 'lorem@ipsum.com'

    validator = PresenceValidator.new(@subject, :name, false)

    assert_raises(
      PresenceValidator::Error,
      "The value for name, should be nil or empty string"
    ) { validator.validate! }

    refute validator.valid?
  end

  def test_raising_an_error_when_rule_is_not_bool_type
    validator = PresenceValidator.new(@subject, :name, nil)

    assert_raises(
      ArgumentError, 'Presence rule should be `true` or `false`'
    ) { validator.valid? }
  end
end
