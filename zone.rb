#zone.rb
#Add dynamic facter value based on IPaddress
#
require('ipaddr')
ip = IPAddr.new(Facter.value('ipaddress'))
#use CIDR
zones= {
  'prod' => IPAddr.new('192.168.10.0/24'),
  'dev' => IPAddr.new('192.168.20.0/24'),
  'build' => IPAddr.new('192.168.30.0/24'),
}

#defualt to undefined
zone= 'undef';

#loop through zones to find the environment
for z in zones.keys do
  if zones[z].include?(ip)
	zone = z
  end
end
#return the facter
Facter.add("zone") do
  setcode do 
	zone
  end
end
