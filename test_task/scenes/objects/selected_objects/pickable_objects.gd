extends Node
@export var exist: bool;

@export var add_Key:int;
@export var add_health:int;
@export var add_max_health:int;
@export var close_all:bool;
func _ready():
	add_to_group("pickable_objects")

func applyObject():
	print("обект взяли")
	PlayerSingleton.keys +=add_Key;
	PlayerSingleton.health += add_health;
	PlayerSingleton.max_health += add_max_health;
	if close_all:
		for key in PlayerSingleton.opentHouse.keys():
			PlayerSingleton.opentHouse[key] = false
	if PlayerSingleton.health <=0 or PlayerSingleton.max_health<=0:
		PlayerSingleton.dead()
	if PlayerSingleton.health > PlayerSingleton.max_health:
		PlayerSingleton.health = PlayerSingleton.max_health

	var scene_name: String = get_tree().get_current_scene().get_name()
	var parentName = get_name();
	if PlayerSingleton.scenes_data.has(scene_name):
		PlayerSingleton.scenes_data[scene_name][parentName] = false
		pass
	queue_free()
