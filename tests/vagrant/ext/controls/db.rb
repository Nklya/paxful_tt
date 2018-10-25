# encoding: utf-8
# copyright: 2018, Nikolay Antsiferov

dbmaster = '10.10.10.20'
dbslave= '10.10.10.21'
port = 5432

# you add controls here
control 'db-1.0' do
  title 'Check db ext'

  describe host(dbmaster, port: port, protocol: 'tcp') do
    it { should be_reachable }
  end

  describe host(dbslave, port: port, protocol: 'tcp') do
    it { should be_reachable }
  end
end
