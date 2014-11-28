require 'spec_helper'

describe 'vim::define', :type => :define do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}
    let(:pre_condition) { 'include vim' }
    let(:title) { 'vimrc' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) {{
          :config_file_source => 'puppet:///modules/vim/wheezy/etc/vim/vimrc',
        }}

        it do
          is_expected.to contain_file('define_vimrc').with({
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/vim/wheezy/etc/vim/vimrc',
            'require' => 'Package[vim]',
          })
        end
      end

      context 'when content string' do
        let(:params) {{
          :config_file_string => '# THIS FILE IS MANAGED BY PUPPET',
        }}

        it do
          is_expected.to contain_file('define_vimrc').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[vim]',
          })
        end
      end

      context 'when content template' do
        let(:params) {{
          :config_file_template => 'vim/wheezy/etc/vim/vimrc.erb',
        }}

        it do
          is_expected.to contain_file('define_vimrc').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[vim]',
          })
        end
      end

      context 'when content template (custom)' do
        let(:params) {{
          :config_file_template     => 'vim/wheezy/etc/vim/vimrc.erb',
          :config_file_options_hash => {
            'key' => 'value',
          },
        }}

        it do
          is_expected.to contain_file('define_vimrc').with({
            'ensure'  => 'present',
            'content' => /THIS FILE IS MANAGED BY PUPPET/,
            'require' => 'Package[vim]',
          })
        end
      end
    end
  end
end
