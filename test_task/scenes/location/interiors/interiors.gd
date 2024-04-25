extends Node2D

var numberStartPosition : int = 0;
@export var startPoints: Array[Node2D];

func state():
	var scene_name: String = get_tree().get_current_scene().get_name()
	
	if PlayerSingleton.scenes_data.has(scene_name):
		var objects_in_group = get_tree().get_nodes_in_group("pickable_objects")
		for object in objects_in_group:
			if 	PlayerSingleton.scenes_data[scene_name][object.get_name()] == false:
				print(object.get_name())
				object.queue_free()
		pass# устанавливаем обекты по значениям
	else:
		PlayerSingleton.scenes_data[scene_name] = {}
		var objects_in_group = get_tree().get_nodes_in_group("pickable_objects")
		for object in objects_in_group:
			PlayerSingleton.scenes_data[scene_name][object.get_name()] = true
			print(object.get_name())
	print("обекты с отслеживаемым состоянием:")
	print(PlayerSingleton.scenes_data)	
	
	
func createPlayer():
	var player = preload("res://scenes/char/player.tscn");
	var new_player = player.instantiate()
	$YSort.add_child(new_player)
	# Установка координат нового объекта
	new_player.position.x = startPoints[numberStartPosition].position.x
	new_player.position.y = startPoints[numberStartPosition].position.y
	new_player.loadData();


func _ready() -> void:
	createPlayer()
	state()
