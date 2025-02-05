extends Control

@onready var day_label = %DayLabel as Label
@onready var time_label = %TimeLabel as Label

@export var normal_speed: int = 5


func _ready():
	DayNightCycleManager.time_tick.connect(_on_time_tick)


func _on_time_tick(day: int, hour: int, minute: int):
	day_label.text = "DAY " + str(day)
	time_label.text = "%02d:%02d" % [hour, minute]
