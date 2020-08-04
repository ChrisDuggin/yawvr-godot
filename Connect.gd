extends RichTextLabel

export (String) var host = "192.168.1.51"
export (int) var tcpPort = 50020
export (int) var udpPort = 50010

var client: StreamPeerTCP
var client_id: int
var local_id_counter: int = 0
var player_scene: PackedScene
var network_objects: Array

func _ready():
	client = StreamPeerTCP.new()
	
	var tcpIp: String = "{host}:{port}".format({
		"host": host,
		"port": tcpPort
	})
	
	var udpIp: String = "{host}:{port}".format({
		"host": host,
		"port": udpPort
	})
	
	
	print("Try Connect : " + tcpIp + "...")

	var error = client.connect_to_host(host, tcpPort)

	if error:
		print("Failed to Connect. Please re-start application to retry.")
		return
	
	emit_signal("network_connected")
	
	set_process(true)
	
	var socket = PacketPeerUDP.new()
	socket.set_dest_address(host, udpPort)
	socket.set_broadcast_enabled(true)
	print("Sending packet to" + udpIp + "..." )
	var pos = "Y[101.000]P[003.000]R[004.000]V[0,0,0,0]"
	var udpErr = socket.put_packet(pos.to_ascii())
	
	print(udpErr)

	print(socket.get_available_packet_count())
	socket.close()

	
