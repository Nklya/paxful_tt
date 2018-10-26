# encoding: utf-8
# copyright: 2018, Nikolay Antsiferov

# you add controls here
control 'dbslave-1.0' do
  title 'Check dbslave'

  describe service('postgresql') do
    it { should be_enabled }
    it { should be_running }
  end

  describe host('localhost', port: 5432, protocol: 'tcp') do
    it { should be_reachable }
  end

  describe command('sudo -u postgres psql -qtAX -c "select pg_is_in_recovery();"') do
    its('stdout') { should eq "t\n" }
  end
end
