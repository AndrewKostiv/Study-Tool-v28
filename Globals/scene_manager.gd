extends Node

var DECKS_MENU = load("uid://d0i7c6sf63oqo")
var EDIT_DECK = load("uid://di75f2r14noph")
var SELECT_STUDY_MODE = load("uid://g33tu54bffwv")
# Study Modes
const MULTIPLE_CHOICE_BUTTONS = preload("uid://ciahsa7paeaae")
const MULTIPLE_CHOICE_TYPING = preload("uid://becxkrps4g60b")

func changeSceneTo(nextScene:PackedScene):
	if !nextScene:
		printerr("There is no nextScene")
		return
	get_tree().change_scene_to_packed(nextScene)
