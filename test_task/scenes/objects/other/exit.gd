extends Area2D
@export var interiorScenes: PackedScene;
@export var fileScenePutch: String;


@export var numberExitPoint:int;

func _ready() -> void:
	interiorScenes = load("res://scenes/location/street/mait_street.tscn")
	print("сцена интерьера загружается")



func _on_area_entered(area):
	area.get_parent().saveData; 
	
	var new_scene_instance = interiorScenes.instantiate()
	new_scene_instance.numberStartPosition = numberExitPoint
	PlayerSingleton.positionOnScene = numberExitPoint;
	get_tree().change_scene_to_packed(interiorScenes)
	
