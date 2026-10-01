class_name StudyModeBase extends Control

@export var study_mode_title: Label

# Called when the node enters the scene tree for the first time.
func setStudyModeTitle(newTitle:String) -> void:
	study_mode_title.text = newTitle

func _on_back_pressed() -> void:
	SceneManager.changeSceneTo(SceneManager.EDIT_DECK)
