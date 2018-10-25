# encoding: utf-8
# copyright: 2018, Nikolay Antsiferov

# you add controls here
control 'app-1.0' do
  title 'Check application'

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('php7.0-fpm') do
    it { should be_enabled }
    it { should be_running }
  end

  describe host('localhost', port: 80, protocol: 'tcp') do
    it { should be_reachable }
  end
end
