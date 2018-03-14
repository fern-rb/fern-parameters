require 'test_helper'
require 'date'
require 'fern/parameters/validator'

module Fern
  module Parameters
    class ValidatorTest < Minitest::Test
      def test_integer
        validator = Validator.new(foo: { type: :integer })
        validator.validate(foo: 1)

        assert_equal({ foo: 1 }, validator.declared)
        assert_equal(false, validator.errors.any?)
      end

      def test_invalid_integer
        validator = Validator.new(foo: { type: :integer })
        validator.validate(foo: 'bar')

        assert_equal(true, validator.errors.any?)
        assert_equal('is not an integer', validator.errors[:foo][0])
      end

      def test_boolean
        validator = Validator.new(foo: { type: :boolean })
        validator.validate(foo: 'true')

        assert_equal({ foo: true }, validator.declared)
        assert_equal(false, validator.errors.any?)
      end

      def test_invalid_boolean
        validator = Validator.new(foo: { type: :boolean })
        validator.validate(foo: 'bar')

        assert_equal(true, validator.errors.any?)
        assert_equal('is not a boolean', validator.errors[:foo][0])
      end

      def test_date
        validator = Validator.new(foo: { type: :date })
        validator.validate(foo: '2018-01-15')

        assert_equal({ foo: Date.parse('2018-01-15') }, validator.declared)
        assert_equal(false, validator.errors.any?)
      end

      def test_invalid_date
        validator = Validator.new(foo: { type: :date })
        validator.validate(foo: 'bar')

        assert_equal(true, validator.errors.any?)
        assert_equal('is not a date', validator.errors[:foo][0])
      end

      def test_required
        validator = Validator.new(foo: { type: :string, required: true })
        validator.validate({})

        assert_equal(true, validator.errors.any?)
        assert_equal('is required', validator.errors[:foo][0])
      end

      def test_default
        validator = Validator.new(foo: { type: :string, default: 'bar' })
        validator.validate({})

        assert_equal(false, validator.errors.any?)
        assert_equal('bar', validator.declared[:foo])
      end

      def test_default_required
        validator = Validator.new(
          foo: { type: :string, default: 'bar', required: true }
        )
        validator.validate({})

        assert_equal(false, validator.errors.any?)
        assert_equal('bar', validator.declared[:foo])
      end

      def test_array
        validator = Validator.new(foo: { type: :integer, array: true })
        validator.validate(foo: %w[1 foo])

        assert_equal(true, validator.errors.any?)
        assert_equal('is not an array of integers', validator.errors[:foo][0])
      end
    end
  end
end
