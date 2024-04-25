extends Node

var max_health :int = 10;
var health :int = max_health;
var keys :int =1 ;
var positionOnScene:int;
# Called when the node enters the scene tree for the first time.
func dead():
	pass
var opentHouse = {
	"barn": false,
	"towern": false,
}

var scenes_data = {
	"scene_name":
		{ 
			"elif ": true
		}
}



func _ready() -> void:
	positionOnScene = 0 # Replace with function body.
	health  = max_health;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
