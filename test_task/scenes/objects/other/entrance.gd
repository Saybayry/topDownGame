extends Area2D
@export var interiorScene: PackedScene;
@export var numberStartPosition: int;
@export var open : bool;
@export var saveName : String;
	
func toNextScene(area: Area2D):
	area.get_parent().saveData;
	var new_scene_instance = interiorScene.instantiate()
	new_scene_instance.numberStartPosition = numberStartPosition
	print(interiorScene)
	get_tree().change_scene_to_packed(interiorScene)
func _ready():
	open = PlayerSingleton.opentHouse[saveName]
	if open:
		$open.visible = true;

func _on_area_entered(area: Area2D) -> void:
	var player = area.get_parent();
	player.saveData();
	if open:
		toNextScene(area)
	elif PlayerSingleton.keys >=1:
		player.spend_key()
		PlayerSingleton.opentHouse[saveName] = true
		$open.visible = true;
		open = true;
		player.saveData();
		print("открыли")
		toNextScene(area)
