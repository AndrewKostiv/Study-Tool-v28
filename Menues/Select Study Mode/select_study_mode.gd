extends Control


func _on_back_pressed() -> void:
	SceneManager.changeSceneTo(SceneManager.EDIT_DECK)
