# encoding: utf-8
require "spanish_vat_validators/version"
require 'active_model'

module ActiveModel::Validations

  module SpanishVatValidatorsHelpers
    def message(kind='spanish_vat')
      I18n.translate!("errors.messages.not_valid_#{kind}") rescue 'is invalid'
    end

    # Validates NIF
    def validate_nif(v)
      return false if v.nil? || v.empty?
      value = v.upcase
      return false unless value.match(/^[0-9]{8}[a-z]$/i)
      letters = "TRWAGMYFPDXBNJZSQVHLCKE"
      check = value.slice!(value.length - 1..value.length - 1)
      calculated_letter = letters[value.to_i % 23].chr
      return check === calculated_letter
    end

    # Validates CIF
    def validate_cif(v)
      return false if v.nil? || v.empty?
      value = v.clone
      return false unless value.match(/^[a-wyz][0-9]{7}[0-9a-z]$/i)
      even = 0
      odd = 0
      uletter = ["J", "A", "B", "C", "D", "E", "F", "G", "H", "I"]
      text = value.upcase
      regular = /^[ABCDEFGHKLMNPQRSVW]\d{7}[0-9,A-J]$/#g);
      if regular.match(value).blank?
        false
      else
        last = text[8,1]

        [1,3,5,7].collect do |cont|
          xxx = (2 * text[cont,1].to_i).to_s + "0"
          odd += xxx[0,1].to_i + xxx[1,1].to_i
          even += text[cont+1,1].to_i if cont < 7
        end

        sum = (even + odd).to_s
        unumber = sum.last.to_i
        unumber = (10 - unumber).to_s
        unumber = 0 if(unumber.to_i == 10)
        ((last.to_i == unumber.to_i) || (last == uletter[unumber.to_i]))
      end
    end

    # Validates NIE
    # a NIE is really a NIF with first number changed to capital X, Y or Z letter
    def validate_nie(v)
      return false if v.nil? || v.empty?
      value = v.upcase
      return false unless value.match(/^[xyz][0-9]{7}[a-z]$/i)
      value[0] = {"X" => "0", "Y" => "1", "Z" => "2"}[value[0]]
      validate_nif(value)
    end
  end

  # Validates any Spanish VAT number
  class ValidSpanishVatValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute, value)
      record.errors.add(attribute, message) unless validate_nif(value) or validate_cif(value) or validate_nie(value)
    end
  end

  # Validates any Spanish person number
  class ValidSpanishIdValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute, value)
      record.errors.add(attribute, message('spanish_id')) unless validate_nif(value) or validate_nie(value)
    end
  end

  # Validates NIF number only
  class ValidNifValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute,value)
      record.errors.add(attribute, message('nif')) unless validate_nif(value)
    end
  end

  # Validates CIF number only
  class ValidCifValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute,value)
      record.errors.add(attribute, message('cif')) unless validate_cif(value)
    end
  end

  # Validates NIE number only
  class ValidNieValidator < ActiveModel::EachValidator
    include SpanishVatValidatorsHelpers
    def validate_each(record, attribute,value)
      record.errors.add(attribute, message('nie')) unless validate_nie(value)
    end
  end

end
