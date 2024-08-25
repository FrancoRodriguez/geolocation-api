# frozen_string_literal: true

require 'rails_helper'
require 'resolv'

RSpec.describe IpFromUrlService do
  describe '.resolve' do
    subject { described_class.resolve(url) }

    context 'when the URL resolves successfully' do
      let(:url) { 'example.com' }
      let(:ip_address) { '93.184.216.34' }

      before do
        allow(Resolv).to receive(:getaddresses).with(url).and_return([ip_address])
      end

      it 'returns the IP address' do
        expect(subject).to eq(ip_address)
      end
    end

    context 'when the URL does not resolve' do
      let(:url) { 'nonexistent.example.com' }

      before do
        allow(Resolv).to receive(:getaddresses).with(url).and_raise(Resolv::ResolvError)
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when the URL resolves to multiple IP addresses' do
      let(:url) { 'example.com' }
      let(:ip_addresses) { ['93.184.216.34', '93.184.216.35'] }

      before do
        allow(Resolv).to receive(:getaddresses).with(url).and_return(ip_addresses)
      end

      it 'returns the first IP address' do
        expect(subject).to eq(ip_addresses.first)
      end
    end

    context 'when the URL is nil' do
      let(:url) { nil }

      before do
        allow(Resolv).to receive(:getaddresses).with(url).and_raise(Resolv::ResolvError)
      end

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end
end
