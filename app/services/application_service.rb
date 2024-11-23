# frozen_string_literal: true

class ApplicationService
  extend ActiveModel::Naming

  def self.call(...)
    new(...).call
  end

  def initialize(*)
    @response = ResponseService.new(self)
  end

  def self.human_attribute_name(_attr, _options = {}); end

  def read_attribute_for_validation(attr); end

  protected

  attr_reader :response

  class ResponseService
    attr_accessor :result
    attr_reader :errors

    def initialize(base)
      @base = base
      @errors = Errors.new(@base)
    end

    def ok?
      errors.empty?
    end

    def add_error(error_key, options = {})
      @errors.add(@base.class.name.underscore, error_key, options)
      self
    end

    def add_result(content)
      @result = content
      self
    end

    class Errors < ActiveModel::Errors
      class Error < ActiveModel::Error
        def self.generate_message(attribute, type = :invalid, _base = nil, options = {})
          key = "services.errors.#{attribute}.#{type}"
          options[:default] = options.delete(:message) if options[:message]

          I18n.t(key, **options)
        end

        def self.full_message(attribute, message, _base)
          super.strip!
        end
      end

      def add(attribute, type = :invalid, options = {})
        attribute, type = normalize_arguments(attribute, type, **options)
        error = Error.new(@base, attribute, type, **options)

        @errors.append(error)

        error
      end
    end
  end
end
