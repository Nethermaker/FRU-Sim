extends AudioStreamPlayer

@export var start_time_sec: float
@export var fade_time_sec: float = 4
@export var initial_volume_db: float = -15

var initial_volume_linear: float

func _ready() -> void:
	GameEvents.sequence_started.connect(on_sequence_started)
	initial_volume_linear = db_to_linear(initial_volume_db)
	play(start_time_sec)
	fade_in()

func on_sequence_started(name: String) -> void:
	pass
	#play(start_time_sec)
	#fade_in()

func fade_in() -> void:
	var elapsed_time: float = 0
	
	volume_db = linear_to_db(0)
	while elapsed_time < fade_time_sec:
		if (!is_inside_tree()):
			break
		await get_tree().process_frame
		elapsed_time += get_process_delta_time()
		volume_db = linear_to_db((elapsed_time / fade_time_sec) * initial_volume_linear)
	volume_db = linear_to_db(initial_volume_linear)
