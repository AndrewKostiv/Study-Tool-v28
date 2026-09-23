extends Node

var DECKS_MENU = load("uid://d0i7c6sf63oqo")
const EDIT_DECK = preload("uid://di75f2r14noph")

func changeSceneTo(nextScene:PackedScene):
	if !nextScene:
		printerr("There is no nextScene")
		return
	get_tree().change_scene_to_packed(nextScene)
