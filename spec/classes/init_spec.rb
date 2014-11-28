require 'spec_helper'

describe 'vim', :type => :class do
  ['Debian'].each do |osfamily|
    let(:facts) {{
      :osfamily => osfamily,
    }}

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_anchor('vim::begin') }
    it { is_expected.to contain_class('vim::params') }
    it { is_expected.to contain_class('vim::install') }
    it { is_expected.to contain_class('vim::config') }
    it { is_expected.to contain_anchor('vim::end') }

    context "on #{osfamily}" do
      describe 'vim::install' do
        context 'defaults' do
          it do
            is_expected.to contain_package('vim').with({
              'ensure' => 'present',
            })
          end
        end

        context 'when package latest' do
          let(:params) {{
            :package_ensure => 'latest',
          }}

          it do
            is_expected.to contain_package('vim').with({
              'ensure' => 'latest',
            })
          end
        end

        context 'when package absent' do
          let(:params) {{
            :package_ensure => 'absent',
          }}

          it do
            is_expected.to contain_package('vim').with({
              'ensure' => 'absent',
            })
          end
          it do
            is_expected.to contain_file('vim.conf').with({
              'ensure'  => 'present',
              'require' => 'Package[vim]',
            })
          end
        end

        context 'when package purged' do
          let(:params) {{
            :package_ensure => 'purged',
          }}

          it do
            is_expected.to contain_package('vim').with({
              'ensure' => 'purged',
            })
          end
          it do
            is_expected.to contain_file('vim.conf').with({
              'ensure'  => 'absent',
              'require' => 'Package[vim]',
            })
          end
        end
      end

      describe 'vim::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('vim.conf').with({
              'ensure'  => 'present',
              'require' => 'Package[vim]',
            })
          end
        end

        context 'when source dir' do
          let(:params) {{
            :config_dir_source => 'puppet:///modules/vim/wheezy/etc/vim',
          }}

          it do
            is_expected.to contain_file('vim.dir').with({
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/vim/wheezy/etc/vim',
              'require' => 'Package[vim]',
            })
          end
        end

        context 'when source dir purged' do
          let(:params) {{
            :config_dir_purge  => true,
            :config_dir_source => 'puppet:///modules/vim/wheezy/etc/vim',
          }}

          it do
            is_expected.to contain_file('vim.dir').with({
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/vim/wheezy/etc/vim',
              'require' => 'Package[vim]',
            })
          end
        end

        context 'when source file' do
          let(:params) {{
            :config_file_source => 'puppet:///modules/vim/wheezy/etc/vim/vimrc',
          }}

          it do
            is_expected.to contain_file('vim.conf').with({
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
            is_expected.to contain_file('vim.conf').with({
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
            is_expected.to contain_file('vim.conf').with({
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
            is_expected.to contain_file('vim.conf').with({
              'ensure'  => 'present',
              'content' => /THIS FILE IS MANAGED BY PUPPET/,
              'require' => 'Package[vim]',
            })
          end
        end
      end
    end
  end
end
