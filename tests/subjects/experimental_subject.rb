class ExperimentalSubject
  include Validation

  def initialize(name: nil, email: nil, belongs_to: nil)
    @name = name
    @email = email
    @belongs_to = belongs_to
    @should_be_empty = ''
  end

  validate :name, :email, presence: true

  validate :name, format: /.+{4}/
  validate :email, format: /.+@.+\..+/
  validate :belongs_to, type: ZeroDivisionError
  validate :should_be_empty, presence: false

  attr_reader :name, :email, :belongs_to, :should_be_empty
end
