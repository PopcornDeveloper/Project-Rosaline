extends Node3D

@onready var main_menu = $CanvasLayer/MainMenu
const Player = preload("res://scenes/player.tscn")
const PORT = 9999
var enet_peer = NodeTunnelPeer.new() 
const DisconnectParticles = preload("res://scenes/particles/disconnect.tscn")

func _ready():
	multiplayer.multiplayer_peer = enet_peer
	enet_peer.connect_to_relay("relay.nodetunnel.io", 9998)
	
	await enet_peer.relay_connected

	%OnlineID.text = enet_peer.online_id

func _on_host_button_pressed() -> void:
	enet_peer.host()

	await enet_peer.hosting

	DisplayServer.clipboard_set(enet_peer.online_id)

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	add_player(multiplayer.get_unique_id())
	main_menu.hide()

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		mist.rpc(player.global_position)
		player.queue_free()
	else:
		printerr("Player not found when disconnecting, player id - " + peer_id)

@rpc("call_local")
func mist(position: Vector3):
	var Partoocle = DisconnectParticles.instantiate()
	get_tree().get_root().add_child(Partoocle)
	Partoocle.position = position
	Partoocle.restart()


func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	player.position.y += 1

func _on_join_button_pressed() -> void:
	enet_peer.join(%HostOnlineID.text)

	await enet_peer.joined
	
	main_menu.hide()
