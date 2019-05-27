RSpec.describe Faker::SpanishDocuments do
  describe '.cif' do
    subject { Faker::SpanishDocuments.cif }

    context 'when province_code is 00' do
      before do
        srand(993)

        expect(Faker::Number).to receive(:number).with(2).and_return('00')
        expect(Faker::Number).to receive(:number).with(5).and_return('20909')
      end

      it 'control code is letter' do
        control_code = subject[-1]

        expect(control_code).to eq('H')
      end

      it 'first letter is valid' do
        first_letter = subject[0]

        expect(described_class::CIF_LETTERS).to include(first_letter)
      end

      it 'structure is valid' do
        expect(subject).to match(/^[A-Z][0-9]{7}[A-Z]|[0-9]$/)
      end
    end

    context 'when control code is letter' do
      before do
        srand(993)

        expect(Faker::Number).to receive(:number).with(2).and_return('40')
        expect(Faker::Number).to receive(:number).with(5).and_return('23909')
      end

      it 'control code is letter' do
        control_code = subject[-1]

        expect(control_code).to eq('G')
      end

      it 'first letter is valid' do
        first_letter = subject[0]

        expect(described_class::CIF_LETTERS).to include(first_letter)
      end

      it 'structure is valid' do
        expect(subject).to match(/^[A-Z][0-9]{7}[A-Z]|[0-9]$/)
      end
    end

    context 'when control code is number' do
      before do
        srand(9993)

        expect(Faker::Number).to receive(:number).with(2).and_return('42')
        expect(Faker::Number).to receive(:number).with(5).and_return('23909')
      end

      it 'control code is number' do
        control_code = subject[-1]

        expect(control_code).to eq('5')
      end

      it 'first letter is valid' do
        first_letter = subject[0]

        expect(described_class::CIF_LETTERS).to include(first_letter)
      end

      it 'structure is valid' do
        expect(subject).to match(/^[A-Z][0-9]{7}[A-Z]|[0-9]$/)
      end
    end

    context 'when letter is provided' do
      let(:first_letter) { 'A' }

      subject { Faker::SpanishDocuments.cif(first_letter) }

      it 'includes first_letter' do
        expect(subject).to start_with(first_letter)
      end
    end

    it 'generates a CIF with the correct size' do
      expect(subject.size).to eq(9)
    end
  end

  describe '.nie' do
    subject { Faker::SpanishDocuments.nie }

    it 'generates a valid NIE' do
      number_part = subject[1..7]
      first_letter = subject[0]
      first_letter_index = described_class::NIE_LETTERS.find_index { |e| e == first_letter }
      last_letter = subject[-1]

      expect(described_class::NIE_LETTERS).to include(first_letter)
      expect(number_part).to match(/[0-9]+/)

      expect(last_letter).to eq(
        described_class::NIF_LETTERS[
          "#{first_letter_index}#{number_part}".to_i % described_class::NIF_LETTERS.length
        ]
      )
    end

    it 'generates a NIE with the correct size' do
      expect(subject.size).to eq(9)
    end

    context 'when letter is provided' do
      let(:first_letter) { 'Z' }

      subject { Faker::SpanishDocuments.nie(first_letter) }

      it 'includes first_letter' do
        expect(subject).to start_with(first_letter)
      end
    end
  end

  describe '.dni' do
    let(:dni) { Faker::SpanishDocuments.dni }

    it 'generates a valid DNI' do
      number_part = dni[0..7]
      letter_part = dni[-1]
      expect(number_part).to match(/[0-9]+/)

      expect(letter_part).to eq(
        described_class::NIF_LETTERS[number_part.to_i % described_class::NIF_LETTERS.length]
      )
    end

    it 'generates a DNI with the correct size' do
      expect(dni.size).to eq 9
    end
  end
end
