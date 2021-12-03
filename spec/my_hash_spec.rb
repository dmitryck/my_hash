# frozen_string_literal: true

require_relative '../my_hash'

RSpec.configure do |config|
  config.default_formatter = 'doc'
end

RSpec.describe MyHash do
  let(:hash) { MyHash.new }

  context 'when no sets in hash' do
    it 'returns nil on any key' do
      expect(hash.get('a')).to be_nil
      expect(hash.get('aa')).to be_nil
    end
  end

  context 'hash sets without collisions' do
    before do
      hash.set('a', 'value1')
      hash.set('aa', 'value2')
    end

    it 'returns values by key' do
      expect(hash.get('a')).to eq('value1')
      expect(hash.get('aa')).to eq('value2')
    end

    it 'updates existing key-value' do
      hash.set('aa', 'foo')

      expect(hash.get('a')).to eq('value1')
      expect(hash.get('aa')).to eq('foo')
    end

    it 'returns nil on missing key' do
      expect(hash.get('z')).to be_nil
      expect(hash.get('zz')).to be_nil
    end
  end

  context 'hash sets with collisions' do
    before do
      hash.set('a', 'value1')
      hash.set('aa', 'value2')
      hash.set('bb', 'value3')
    end

    it 'returns values by key' do
      expect(hash.get('a')).to eq('value1')
      expect(hash.get('aa')).to eq('value2')
      expect(hash.get('bb')).to eq('value3')
    end

    it 'updates existing collision key-value' do
      hash.set('bb', 'foo')

      expect(hash.get('a')).to eq('value1')
      expect(hash.get('aa')).to eq('value2')
      expect(hash.get('bb')).to eq('foo')
    end
  end
end
