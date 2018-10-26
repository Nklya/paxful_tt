# encoding: utf-8
# copyright: 2018, Nikolay Antsiferov

dbmaster = attribute ('dbmaster')
dbslave = attribute ('dbslave')
port = 5432

control 'db-1.0' do
  title 'Check db ext'

  describe host(dbmaster, port: port, protocol: 'tcp') do
    it { should be_reachable }
  end

  describe host(dbslave, port: port, protocol: 'tcp') do
    it { should be_reachable }
  end
end
