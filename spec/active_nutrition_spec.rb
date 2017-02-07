require 'spec_helper'

describe ActiveNutrition do
  describe '.search' do
    it 'finds the expected food' do
      salt = described_class.search('table salt').first
      expect(salt.name).to eq('Salt, table')
    end

    it 'finds the expected food by reversing the search terms' do
      salt = described_class.search('salt table').first
      expect(salt.name).to eq('Salt, table')
    end
  end

  describe '.get' do
    it 'retrieves a food by its ndb number' do
      butter = described_class.get(1001)
      expect(butter.name).to eq('Butter, salted')
    end
  end

  describe '.convert' do
    it 'converts units' do
      expect(described_class.convert(2, from: :lb, to: :oz)).to eq(32)
    end
  end

  describe '.supported_conversion?' do
    it 'returns true if the conversion is supported' do
      expect(described_class.supported_conversion?(from: :lb, to: :oz)).to eq(true)
    end

    it 'returns false if the conversion is not supported' do
      expect(described_class.supported_conversion?(from: :lb, to: :cup)).to eq(false)
    end
  end
end
