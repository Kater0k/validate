Dir['./validators/**/*.rb'].each { |validator| require validator }

module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  def validate!
    self.class.validations_each(self, &:validate!)
  end

  def valid?
    !!self.class.validations_each(self) do |validator|
      break false unless validator.valid?
    end
  end

  private

  module ClassMethods
    # small improvement - can accept multiple attributes
    def validate(*attrs, **options)
      if options.empty?
        raise ArgumentError, "At least one validation should be provided"
      end

      if attrs.empty?
        raise ArgumentError, "At least one attribute should be provided"
      end

      attrs.each { |attr| validations << [attr, options] }
    end

    def validations
      @validations ||= []
    end

    def validations_each(object)
      validations.each do |attr, options|
        options.each do |type, rules|
          validator =
            Object
              .const_get("#{type.capitalize}Validator")
              .new(object, attr, rules)

          yield(validator) if block_given?
        end
      end
    end
  end
end
