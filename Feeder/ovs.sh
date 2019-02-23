export mac=$(ifconfig -a | grep -Po 'HWaddr \K.*$')
sudo modprobe openvswitch
sudo /etc/init.d/openvswitch-switch start
sudo ovs-vsctl del-br feeder
sudo ovs-vsctl add-br feeder
sudo ovs-vsctl set bridge feeder other-config:hwaddr=$mac
sudo ovs-vsctl add-port feeder eth0
sudo ip addr del 10.1.0.21/24 dev eth0
sudo ip addr add 10.1.0.21/24 dev feeder
sudo ip route del default via 10.1.0.1 dev eth0
sudo ifconfig feeder up
sudo ip route add default via 10.1.0.1 dev feeder
sudo ovs-vsctl show
sudo ovs-vsctl list-br

sudo ip tuntap add mode tap p0
sudo ifconfig p0 up
sudo ip tuntap add mode tap p1
sudo ifconfig p1 up
sudo ip tuntap add mode tap p2
sudo ifconfig p2 up
sudo ip tuntap add mode tap p3
sudo ifconfig p3 up

sudo ovs-vsctl add-port feeder p0
sudo ovs-vsctl add-port feeder p1
sudo ovs-vsctl add-port feeder p2
sudo ovs-vsctl add-port feeder p3

sudo ip addr add 10.1.0.21/24 dev p0
sudo ip addr add 10.1.0.21/24 dev p1
sudo ip addr add 10.1.0.21/24 dev p2
sudo ip addr add 10.1.0.21/24 dev p3