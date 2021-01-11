class BaseValidator
  def initialize(object, attr, rule)
    @valid = false
    @object = object
    @attr = attr
    @rule = rule
    @value = object.public_send(attr)
  end

  def validate!
    raise exception unless validate
  end

  def valid?
    validate
  end

  private

  def validate
    raise NotImplementedError, "should be implemented"
  end

  def exception
    raise NotImplementedError, "should be implemented"
  end
end
