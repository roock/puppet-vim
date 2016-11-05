require 'spec_helper'

describe 'vim', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_anchor('vim::begin') }
      it { is_expected.to contain_class('vim::params') }
      it { is_expected.to contain_class('vim::install') }
      it { is_expected.to contain_class('vim::config') }
      it { is_expected.to contain_anchor('vim::end') }

      describe 'vim::install' do
        context 'defaults' do
          it do
            is_expected.to contain_package('vim').with(
              'ensure' => 'present'
            )
          end
        end

        context 'when package latest' do
          let(:params) do
            {
              package_ensure: 'latest'
            }
          end

          it do
            is_expected.to contain_package('vim').with(
              'ensure' => 'latest'
            )
          end
        end

        context 'when package absent' do
          let(:params) do
            {
              package_ensure: 'absent'
            }
          end

          it do
            is_expected.to contain_package('vim').with(
              'ensure' => 'absent'
            )
          end
          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'present',
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when package purged' do
          let(:params) do
            {
              package_ensure: 'purged'
            }
          end

          it do
            is_expected.to contain_package('vim').with(
              'ensure' => 'purged'
            )
          end
          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'absent',
              'require' => 'Package[vim]'
            )
          end
        end
      end

      describe 'vim::config' do
        context 'defaults' do
          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'present',
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when source dir' do
          let(:params) do
            {
              config_dir_source: 'puppet:///modules/vim/wheezy/etc/vim'
            }
          end

          it do
            is_expected.to contain_file('vim.dir').with(
              'ensure'  => 'directory',
              'force'   => false,
              'purge'   => false,
              'recurse' => true,
              'source'  => 'puppet:///modules/vim/wheezy/etc/vim',
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when source dir purged' do
          let(:params) do
            {
              config_dir_purge: true,
              config_dir_source: 'puppet:///modules/vim/wheezy/etc/vim'
            }
          end

          it do
            is_expected.to contain_file('vim.dir').with(
              'ensure'  => 'directory',
              'force'   => true,
              'purge'   => true,
              'recurse' => true,
              'source'  => 'puppet:///modules/vim/wheezy/etc/vim',
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when source file' do
          let(:params) do
            {
              config_file_source: 'puppet:///modules/vim/wheezy/etc/vim/vimrc'
            }
          end

          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'present',
              'source'  => 'puppet:///modules/vim/wheezy/etc/vim/vimrc',
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when content string' do
          let(:params) do
            {
              config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
            }
          end

          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when content template' do
          let(:params) do
            {
              config_file_template: 'vim/wheezy/etc/vim/vimrc.erb'
            }
          end

          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when content template (custom)' do
          let(:params) do
            {
              config_file_template: 'vim/wheezy/etc/vim/vimrc.erb',
              config_file_options_hash: {
                'key' => 'value'
              }
            }
          end

          it do
            is_expected.to contain_file('vim.conf').with(
              'ensure'  => 'present',
              'content' => %r{THIS FILE IS MANAGED BY PUPPET},
              'require' => 'Package[vim]'
            )
          end
        end

        context 'when default editor' do
          let(:params) do
            {
              default_editor: true
            }
          end

          it do
            is_expected.to contain_exec('update-alternatives').with(
              'command' => 'update-alternatives --set editor /usr/bin/vim.basic',
              'unless'  => 'test /etc/alternatives/editor -ef /usr/bin/vim.basic',
              'require' => 'Package[vim]'
            )
          end
        end
      end
    end
  end
end
