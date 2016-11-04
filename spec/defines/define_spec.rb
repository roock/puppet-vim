require 'spec_helper'

describe 'vim::define', type: :define do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:pre_condition) { 'include vim' }
      let(:title) { 'vimrc' }

      context 'when source file' do
        let(:params) do
          {
            config_file_path: '/etc/vim/vimrc.2nd',
            config_file_source: 'puppet:///modules/vim/wheezy/etc/vim/vimrc'
          }
        end

        it do
          is_expected.to contain_file('define_vimrc').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/vim/wheezy/etc/vim/vimrc',
            'require' => 'Package[vim]'
          )
        end
      end

      context 'when content string' do
        let(:params) do
          {
            config_file_path: '/etc/vim/vimrc.3rd',
            config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
          }
        end

        it do
          is_expected.to contain_file('define_vimrc').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => 'Package[vim]'
          )
        end
      end

      context 'when content template' do
        let(:params) do
          {
            config_file_path: '/etc/vim/vimrc.4th',
            config_file_template: 'vim/wheezy/etc/vim/vimrc.erb'
          }
        end

        it do
          is_expected.to contain_file('define_vimrc').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => 'Package[vim]'
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) do
          {
            config_file_path: '/etc/vim/vimrc.5th',
            config_file_template: 'vim/wheezy/etc/vim/vimrc.erb',
            config_file_options_hash: {
              'key' => 'value'
            }
          }
        end

        it do
          is_expected.to contain_file('define_vimrc').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'require' => 'Package[vim]'
          )
        end
      end
    end
  end
end
