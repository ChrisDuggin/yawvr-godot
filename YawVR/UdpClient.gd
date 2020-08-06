# Class UdpClient.gd
var host
var port
var socket

func _init(_host: String, _port: int):
	self.host = _host
	self.port = _port

	self.socket = PacketPeerUDP.new()
	self.socket.set_dest_address(self.host, self.port)
	self.socket.set_broadcast_enabled(true)

func send(y,p,r,v):
	#Format: Y[000.000]P[000.000]R[000.000]V[0,0,0,0]
	var position: String = "Y[{y}]P[{p}]R[{r}]V[{v}]".format({"y":y, "p":p, "r":r, "v":v})
	self.socket.put_packet(position.to_ascii())

	print("Sending --" + position + "-- to " + self.host + "..." )

func close():
	self.socket.close()
	print("closed")
