require 'faker'
require 'faker_spanish_documents/version'

module Faker
  class SpanishDocuments
    NIF_LETTERS = 'TRWAGMYFPDXBNJZSQVHLCKE'.freeze
    NIE_LETTERS = %w[X Y Z].freeze
    CIF_LETTERS = %w[A B C D E F G H J N P Q R S U V W].freeze
    CIF_LETTERS_NUMBER = 'PQSW'.freeze
    CIF_CONTROL_LETTERS = 'JABCDEFGHI'.freeze

    class << self
      def dni
        number = Faker::Number.number(8).to_i
        "#{number}#{nif_letter(number)}"
      end

      def nie(letter=nil)
        first_letter = letter && NIE_LETTERS.include?(letter) ? letter : NIE_LETTERS.sample
        first_number = NIE_LETTERS.find_index { |e| e == first_letter }
        number_part = Faker::Number.number(7)
        number_for_calculation = "#{first_number}#{number_part}".to_i

        "#{first_letter}#{number_part}#{nif_letter(number_for_calculation)}"
      end

      def cif(letter=nil)
        first_letter = letter && CIF_LETTERS.include?(letter) ? letter : CIF_LETTERS.sample
        province_code = Faker::Number.number(2)
        random_number = Faker::Number.number(5)
        number = "#{province_code}#{random_number}"

        control_code = cif_control_code(number, first_letter)

        "#{first_letter}#{number}#{control_code}"
      end

      private

      def cif_control_code(number, first_letter)
        total = number
                .split('')
                .each_with_index
                .inject(0) do |acc, (element, index)|
          acc += if index.even?
                   (element.to_i * 2).digits.inject(:+)
                 else
                   element.to_i
                 end
        end

        decimal = total.digits.first
        control = decimal != 0 ? 10 - decimal : decimal

        if CIF_LETTERS_NUMBER.include?(first_letter) || number.start_with?('00')
          # Control code will be a letter
          CIF_CONTROL_LETTERS[control]
        else
          # Control code will be a number
          control
        end
      end

      def nif_letter(number)
        NIF_LETTERS[number % NIF_LETTERS.length]
      end
    end
  end
end
