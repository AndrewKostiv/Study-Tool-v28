class_name Card extends Resource

@export var question:String
@export var answer:String
@export var isFavored:bool

func _init(newQuesion:String = "", newAnswer:String = "", newIsFavored:bool = false) -> void:
	question = newQuesion
	answer = newAnswer
	isFavored = newIsFavored
