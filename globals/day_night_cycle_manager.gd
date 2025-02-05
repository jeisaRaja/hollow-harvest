extends Node

const MINUTES_PER_DAY: int = 24 * 60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

var game_speed: float = 20.0

var initial_day: int = 1
var initial_hour: int = 12
var initial_minute: int = 30

var time: float = 0.0
var current_minute: int = -1
var current_day: int = 0

signal game_time(time: float)
signal time_tick(day: int, hour: int, minute: int)
signal time_tick_day(day: int)


func _ready():
	Lobby.player_connected.connect(_on_player_connected)
	set_initial_time()


func _on_player_connected(player_id: int, _player_info):
	if (
		get_multiplayer_authority() == multiplayer.get_unique_id()
		and player_id != multiplayer.get_unique_id()
	):
		set_current_time.rpc_id(player_id, time)


@rpc("authority", "call_remote")
func set_current_time(server_time: float):
	time = server_time


func _process(delta):
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)

	recalculate_time()


func set_initial_time() -> void:
	var initial_total_minutes = (
		initial_day * MINUTES_PER_DAY + (initial_hour * MINUTES_PER_HOUR) + initial_minute
	)

	time = initial_total_minutes * GAME_MINUTE_DURATION


func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTE_DURATION)
	var day: int = int(total_minutes / MINUTES_PER_DAY)
	var current_day_minutes: int = total_minutes % MINUTES_PER_DAY
	var hour: int = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute: int = current_day_minutes % MINUTES_PER_HOUR

	if current_minute != minute:
		current_minute = minute
		time_tick.emit(day, hour, minute)

	if current_day != day:
		current_day = day
		time_tick_day.emit(day)
