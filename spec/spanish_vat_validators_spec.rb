require 'spec_helper'

describe ActiveModel::Validations::ValidSpanishVatValidator do
  describe '#validate_each' do
    it 'does not add errors with a valid number' do
      %w[22472947S S6185663I Y8527549Z].each do |identification_number|
        record = build_record(identification_number)
        should_be_valid(record)
      end
    end

    it 'adds errors with an invalid number' do
      %w[Y8527549 S618-5663I 000 Y1527549Z invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record)
      end
    end

    it 'adds errors with an invalid number and custom message' do
      %w[Y8527549 S618-5663I 000 Y1527549Z invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record, 'invalid')
      end
    end
  end
end

describe ActiveModel::Validations::ValidSpanishIdValidator do
  describe '#validate_each' do
    it 'does not add errors with a valid number' do
      %w[22472947S 96380632Y 28459349T 35696134L 86159868M 29052409M
         Y8527549Z Y8305424T X9393496C X0012309G Y9370869Q Y2995306F].each do |identification_number|
        record = build_record(identification_number)
        should_be_valid(record)
      end
    end

    it 'adds errors with an invalid number' do
      %w[1234 96380632 284-59349T 5696134L S6185663I invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record)
      end
    end

    it 'adds errors with an invalid number and custom message' do
      %w[1234 96380632 284-59349T 5696134L S6185663I invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record, 'invalid')
      end
    end
  end
end

describe ActiveModel::Validations::ValidNifValidator do
  describe '#validate_each' do
    it 'does not add errors with a valid number' do
      %w[22472947S 96380632Y 28459349T 35696134L 86159868M 29052409M].each do |identification_number|
        record = build_record(identification_number)
        should_be_valid(record)
      end
    end

    it 'adds errors with an invalid number' do
      %w[1234 96380632 284-59349T 5696134L S6185663I Y8527549Z invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record)
      end
    end

    it 'adds errors with an invalid number and custom message' do
      %w[1234 96380632 284-59349T 5696134L S6185663I Y8527549Z invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record, 'invalid')
      end
    end
  end
end

describe ActiveModel::Validations::ValidCifValidator do
  describe '#validate_each' do
    it 'does not add errors with a valid number' do
      %w[S6185663I C2871341J G37880135 F43766880 A58818501 J27950005 V63423321].each do |identification_number|
        record = build_record(identification_number)
        should_be_valid(record)
      end
    end

    it 'adds errors with an invalid number' do
      %w[1234 2871341J 284-59349T 22472947S Y8527549Z invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record)
      end
    end

    it 'adds errors with an invalid number and custom message' do
      %w[1234 2871341J 284-59349T 22472947S Y8527549Z invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record, 'invalid')
      end
    end
  end
end

describe ActiveModel::Validations::ValidNieValidator do
  describe '#validate_each' do
    it 'does not add errors with a valid number' do
      %w[Y8527549Z Y8305424T X9393496C X0012309G Y9370869Q Y2995306F].each do |identification_number|
        record = build_record(identification_number)
        should_be_valid(record)
      end
    end

    it 'adds errors with an invalid number' do
      %w[8527549Z 22472947S 000 S6185663I invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record)
      end
    end

    it 'adds errors with an invalid number and custom message' do
      %w[8527549Z 22472947S 000 S6185663I invalid_zip].each do |identification_number|
        record = build_record(identification_number)
        should_be_invalid(record, 'invalid')
      end
    end
  end
end

def should_be_valid(record)
  described_class.new(attributes: :identification_number).validate(record)
  expect(record.errors).to be_empty
end

def should_be_invalid(record, message = nil)
  params = { attributes: :identification_number }
  params[:message] = message if message
  described_class.new(params).validate(record)
  expect(record.errors.size).to eq 1
  expect(record.errors.messages[:identification_number]).to include(message || 'is invalid')
end

def build_record(identification_number)
  ValidationDummyClass.new.tap do |object|
    object.identification_number = identification_number
  end
end

class ValidationDummyClass
  include ::ActiveModel::Validations
  attr_accessor :identification_number

  def self.name
    'TestClass'
  end
end
