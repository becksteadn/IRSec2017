netsh advfirewall reset
netsh advfirewall allprofiles state on
netsh advfirewall allprofiles firewallpolicy blockinbound, blockoutbound
netsh advfirewall firewall add rule name=ping action=allow protocol=icmpv4:8,any dir=in
netsh advfirewall firewall add rule name=loop action=allow dir=in remoteip=127.0.0.0/8
netsh advfirewall firewall name"ssh" dir=in action=allow protocol=tcp localport=22
netsh advfirewall firewall add rule name=dns,dhcp action=allow protocol=udp remoteport=53,68 dir=out
