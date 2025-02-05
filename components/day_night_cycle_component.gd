class_name DayNightCycleComponent
extends CanvasModulate

@export var day_night_gradient_texture: GradientTexture1D

@export var initial_day: int = 1:
	set(id):
		initial_day = id
		DayNightCycleManager.initial_day = id
		DayNightCycleManager.set_initial_time()

@export var initial_hour: int = 12:
	set(ih):
		initial_hour = ih
		DayNightCycleManager.initial_hour = ih
		DayNightCycleManager.set_initial_time()

@export var initial_minute: int = 30:
	set(im):
		initial_minute = im
		DayNightCycleManager.initial_minute = im
		DayNightCycleManager.set_initial_time()


func _ready():
	DayNightCycleManager.initial_day = initial_day
	DayNightCycleManager.initial_hour = initial_hour
	DayNightCycleManager.initial_minute = initial_minute
	DayNightCycleManager.set_initial_time()

	DayNightCycleManager.game_time.connect(_on_game_time)


func _on_game_time(time: float):
	var sample_value = 0.5 * (sin(time - PI * 0.5) + 1)
	color = day_night_gradient_texture.gradient.sample(sample_value)
