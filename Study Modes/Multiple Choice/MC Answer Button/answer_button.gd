extends Button
class_name MC_Answer_Button

signal on_answer(text:String)

func setData(newAnswer:String) -> void:
	text = newAnswer

func _on_pressed() -> void:
	on_answer.emit(text)
