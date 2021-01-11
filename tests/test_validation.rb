require 'minitest/autorun'
require '../validation'
require '../subjects/experimental_subject'

class TestValidation < Minitest::Test
  def test_that_experimental_subject_valid
    experimental_subject = ExperimentalSubject.new(
      name: 'Schrodinger cat',
      email: 'exists_or_not_exists@that_is_the_question.com',
      belongs_to: ZeroDivisionError.new('Cat, do something!')
    )

    experimental_subject.validate!

    assert experimental_subject.valid?
  end

  def test_that_experimental_subject_invalid
    experimental_subject = ExperimentalSubject.new(
      name: '',
      email: 'exists_or_not_exists@that_is_the_question.com',
      belongs_to: ZeroDivisionError.new('Cat, do something!')
    )

    assert_raises(
      PresenceValidator::Error,
      "The value for name, can't be `nil` or empty string"
    ) { experimental_subject.validate! }

    refute experimental_subject.valid?
  end
end
