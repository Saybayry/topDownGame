extends CanvasLayer

var message_timer = Timer.new()

func _ready():
	pass
	# Подключаем таймер к сигналу таймера "timeout"
	#message_timer.connect("timeout", self, "_on_message_timer_timeout")

func _process(delta):
	$kysLable.text = str(PlayerSingleton.keys)
	$hpLable.text = str(PlayerSingleton.health) + "/" + str(PlayerSingleton.max_health)

# Функция для показа сообщения на какое-то время
func show_message(message: String, duration: float):
	$messageLable.text = message
	$Timer.wait_time = duration
	$Timer.start()


func _on_timer_timeout():
	$messageLable.text = ""
