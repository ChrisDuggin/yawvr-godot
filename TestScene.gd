extends Spatial
var UdpClient = preload("res://YawVR/UdpClient.gd")

#todo don't static code the ip
export (String) var host = "192.168.1.51"
export (int) var port = 50010

export (String) var yaw = "000.000"
export (String) var pitch = "000.000"
export (String) var roll = "000.000"
export (String) var velocity = "0,0,0,0"

var client
var prevRotation
func _ready():
	print("getting ready")
	client = UdpClient.new(host, port)	
	client.send(yaw,pitch,roll,velocity)

func _process(delta):
	if(rotation != prevRotation):
		#todo: handle transform correctly
		client.send(rotation.x*100, rotation.y*100, rotation.z*100, velocity)	
		prevRotation = rotation
	
func _exit_tree():
	client.close()
