require 'minitest/autorun'
require '../validators/type_validator'

class TestFormatValidator < Minitest::Test
  def setup
    @subject = OpenStruct.new(belongs_to: {})
  end

  def test_should_be_valid
    validator = TypeValidator.new(@subject, :belongs_to, Hash)

    assert validator.valid?
  end

  def test_should_be_invalid
    @subject.email = []

    validator = TypeValidator.new(@subject, :belongs_to, Hash)

    assert_raises(
      TypeValidator::Error,
      "The value of belongs_to should be istance of `Hash`"
    ) { validator.validate! }

    refute validator.valid?
  end

  def test_raising_an_error_when_rule_is_not_a_class
    validator = TypeValidator.new(@subject, :belongs_to, 'Wrong rule')

    assert_raises(
      ArgumentError, 'Type rule should be a Class'
    ) { validator.valid? }
  end
end
