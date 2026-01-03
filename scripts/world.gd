extends Node3D

@onready var main_menu = $CanvasLayer/MainMenu
@onready var spawner = $MultiplayerSpawner
const Player = preload("res://scenes/player.tscn")
const PORT = 9999
var enet_peer = NodeTunnelPeer.new() 
const DisconnectParticles = preload("res://scenes/ragdoll.tscn")

func _ready():
	multiplayer.multiplayer_peer = enet_peer
	
	enet_peer.connect_to_relay("relay.nodetunnel.io", 9998)
	
	main_menu.hide()
	$CanvasLayer/Label.show()
	$CanvasLayer/Label2.visible_ratio = 0
	
	await enet_peer.relay_connected
	
	$CanvasLayer/Label.hide()
	main_menu.show()

	%OnlineID.text = enet_peer.online_id
	if OS.has_feature("dedicated_server"):
		print("Starting Dedicated Server...")
		enet_peer.host()
		await enet_peer.hosting
	
		DisplayServer.clipboard_set(enet_peer.online_id)
		print("Copied online ID")
	
		multiplayer.peer_connected.connect(add_player)
		multiplayer.peer_disconnected.connect(remove_player)

func _on_host_button_pressed() -> void:
	enet_peer.host()
	
	main_menu.hide()
	$CanvasLayer/Label.show()

	await enet_peer.hosting

	DisplayServer.clipboard_set(enet_peer.online_id)

	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	add_player(multiplayer.get_unique_id())
	
	$CanvasLayer/Label.hide()

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		spawner.spawn_function = spawn
		spawner.clear_spawnable_scenes()
		spawner.add_spawnable_scene("res://scenes/ragdoll.tscn")
		var plark = spawner.spawn(DisconnectParticles)
		
		plark.global_position = player.global_position
		plark.global_rotation = player.global_rotation
		
		plark.rag.rpc()
		
		player.queue_free()
	else:
		printerr("Player not found when disconnecting, player id - " + peer_id)
	

func spawn(node):
	var Partoocle = node.instantiate()
	return Partoocle

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	player.position.y += 1
func _on_join_button_pressed() -> void:
	
	if %HostOnlineID.text != null and %HostOnlineID.text != "":
		enet_peer.join(%HostOnlineID.text)
	else:
		$CanvasLayer/MainMenu/MarginContainer/VBoxContainer/ErrorLabel.text = "ERROR : NO INPUT FOR THE HOST ID"
		return

	main_menu.hide()
	$CanvasLayer/Label.show()

	await enet_peer.joined
	
	$CanvasLayer/Label.hide()
