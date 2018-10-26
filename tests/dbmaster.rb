# encoding: utf-8
# copyright: 2018, Nikolay Antsiferov

# you add controls here
control 'dbmaster-1.0' do
  title 'Check dbmaster'

  describe service('postgresql') do
    it { should be_enabled }
    it { should be_running }
  end

  describe host('localhost', port: 5432, protocol: 'tcp') do
    it { should be_reachable }
  end

  describe command('sudo -u postgres psql -qtAX -c "SELECT state FROM pg_stat_replication;"') do
    its('stdout') { should eq "streaming\n" }
  end

  describe command('sudo -u postgres psql -qtAX -c "select pg_is_in_recovery();"') do
    its('stdout') { should eq "f\n" }
  end
end
