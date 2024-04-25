extends CharacterBody2D

const SPEED = 300.0

@export var max_health :int = 10;
@export var health :int;
@export var keys :int;




@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


enum PlayerState {
	IDLE,
	WALK,
	RUN,
	JUMP
}
enum Directions{
	UP,
	DOWN,
	RIGHT,
	LEFT
}

var current_direction = Directions.DOWN;
var current_state = PlayerState.IDLE

func handle_idle_state():
	match current_direction:
		Directions.UP:
			animated_sprite.play("ide_up")
		Directions.DOWN:
			animated_sprite.play("ide_down")
		Directions.LEFT:
			animated_sprite.play("ide_left")
		Directions.RIGHT:
			animated_sprite.play("ide_right")

func handle_walk_state():
	match current_direction:
		Directions.UP:
			animated_sprite.play("walk_up")
		Directions.DOWN:
			animated_sprite.play("walk_down")
		Directions.LEFT:
			animated_sprite.play("walk_left")
		Directions.RIGHT:
			animated_sprite.play("walk_right")

func handle_run_state():
	print("В состоянии бега")

func setDirection(direction):
	if direction.x > 0:
		current_direction = Directions.RIGHT
	elif  direction.x<0:
		current_direction=Directions.LEFT
	elif  direction.y<0:
		current_direction=Directions.UP
	elif  direction.y>0:
		current_direction=Directions.DOWN

func setDirectionArea(direction):
	print("двигаю")
	if direction.x > 0:
		current_direction = Directions.RIGHT
		# Изменяем координаты объекта на (1, 0) относительно текущей позиции
		$interactive_object.position = Vector2(12, 3)
	elif direction.x < 0:
		current_direction = Directions.LEFT
		# Изменяем координаты объекта на (-1, 0) относительно текущей позиции
		$interactive_object.position = Vector2(-12, 3)
	elif direction.y < 0:
		current_direction = Directions.UP
		# Изменяем координаты объекта на (0, -1) относительно текущей позиции
		$interactive_object.position = Vector2(0, -9)
	elif direction.y > 0:
		current_direction = Directions.DOWN
		# Изменяем координаты объекта на (0, 1) относительно текущей позиции
		$interactive_object.position = Vector2(0, 9)


func processPlayerInput():
	var direction = Vector2()
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
		if current_state != PlayerState.WALK:
			current_state = PlayerState.WALK;
		setDirection(direction)
		setDirectionArea(direction)
	elif velocity == Vector2.ZERO:
		current_state = PlayerState.IDLE
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func _physics_process(delta: float) -> void:
	loadData()
	processPlayerInput()
	match current_state:
		PlayerState.IDLE:
			handle_idle_state()
		PlayerState.WALK:
			handle_walk_state()
		PlayerState.RUN:
			handle_run_state()



func _on_enter_room_collider_area_entered(area: Area2D) -> void:
	if area.is_in_group("entrance"):
		saveData()
	print("в зоне");
	pass # Replace with function body.
	
func spend_key() -> bool:
	if keys >= 1:
		# логика вывода окна да нет
		keys= keys - 1;
		PlayerSingleton.keys =PlayerSingleton.keys -1;
		return true
	else:
		return false
		
func loadData():
		max_health = PlayerSingleton.max_health ;
		health = PlayerSingleton.health;
		keys = PlayerSingleton.keys;
func saveData():
		PlayerSingleton.max_health = max_health;
		PlayerSingleton.health = health;
		PlayerSingleton.keys = keys;


func _on_object_picable_area_entered(area):
	if area.get_parent().is_in_group("pickable_objects"):
		area.get_parent().applyObject();
	pass # Replace with function body.

func show_message(text):
	$Hud.show_message(text,2.0)

func _input(event):
	if event.is_action_pressed("ui_use"):
		var area = $interactive_object
		area.monitoring = false
		area.monitoring = true

func _on_interactive_object_area_entered(area):
	if Input.is_action_pressed("ui_use"):
		show_message(area.get_parent().text)

