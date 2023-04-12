# frozen_string_literal: true

require 'spec_helper'

describe 'sysctl::before' do
  let(:title) { 'sysctl::before' }
  let(:params) { { value: 'title' } }

  it 'raises an error about needing the sysctl::common class' do
    expect do
      expect(subject).to create_notify('message-title')
        .with_message('This should print if the class is here first.')
    end
      .to raise_error(Puppet::Error, /Could not find resource 'Class\[Sysctl::Common\]/)
  end
end

describe 'sysctl::before' do
  let(:title) { 'test define' }
  let(:pre_condition) do
    ['# we need sysctl common',
     'class {"sysctl::common":}']
  end
  let(:params) { { value: 'title' } }

  it { is_expected.to create_sysctl__before('test define').with_value('title') }

  it { is_expected.to contain_class('sysctl::common') }
end
