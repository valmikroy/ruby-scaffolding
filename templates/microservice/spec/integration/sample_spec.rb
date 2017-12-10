# frozen_string_literal: true

require 'spec_helper'

describe 'Health endpoiont', js: true, type: :feature do
  context 'health' do
    it 'health check ' do
      visit '/api/health'
      expect(body).to eq('<html><head></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">{"OK":"Health ok with debug param false"}</pre></body></html>')
    end
  end
  context 'endpoints' do
    it 'v1_unavailable' do
      visit '/api/v2/ns1/ns22/v1_unavailable'
      expect(body).to eq('<html><head></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">{"OK":"only available in v1"}</pre></body></html>')
    end

  end
end