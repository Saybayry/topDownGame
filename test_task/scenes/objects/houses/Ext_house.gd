extends Node2D

@export var interiorScene: PackedScene

func toInteriorScene() -> void:
	get_tree().change_scene_to_packed(interiorScene)
	
	
func _on_entrance_area_entered(area: Area2D) -> void:
	#toInteriorScene()
	pass
	
