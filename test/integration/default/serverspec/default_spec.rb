require_relative './spec_helper'

describe 'ansible-postfix::default' do

  describe file('/etc/postfix/main.cf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end

  describe package('bsd-mailx') do
    it { should be_installed }
  end

  describe package('postfix') do
    it { should be_installed }
  end

  describe file('/lib/systemd/system/postfix.service') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end

  describe service('postfix') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(25) do
    it { should be_listening }
  end

  describe command('echo "Test email" | mail -s "Test" root') do
    its(:exit_status) { should eq 0 }
  end

end
