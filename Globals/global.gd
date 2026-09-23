extends Node
const dataPath:String = "res://Resources/Data.tres"
@export var data: Data = load(dataPath)

func _ready() -> void:
	if !data:
		data = Data.new()
		return
	else:
		loadData()
	return

func saveData() -> void:
	ResourceSaver.save(data, dataPath)

func loadData() -> void:
	data = load(dataPath)

func _input(event: InputEvent) -> void:
	if event.is_action_released("save"):
		saveData()
