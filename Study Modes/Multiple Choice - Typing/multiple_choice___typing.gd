extends Control

@onready var deck = Global.data.activeDeck
@export var study_mode_base: StudyModeBase
@export var user_input: LineEdit
@export var quesiton_label: Label
var activeCard:Card
var startTime:int

const _MODE_TITLE:String = "Multiple Choice - Typing"

func _ready() -> void:
	study_mode_base.setStudyModeTitle(_MODE_TITLE)
	getQuesiton()
	user_input.edit()

func getQuesiton() -> void:
	activeCard = deck.getCard()
	quesiton_label.text = activeCard.question
	startTime = Time.get_ticks_msec()

func _on_user_input_text_submitted(new_text: String) -> void:
	if new_text == activeCard.answer:
		var endTime = Time.get_ticks_msec()
		activeCard.onAnswer(activeCard.MAX_ACCURACY, endTime-startTime)
		print_debug("Correct")
		getQuesiton()
	else:
		activeCard.onAnswer(activeCard.MIN_ACCURACY)
		print_debug("Incorrect, correct is ", activeCard.answer)
	user_input.clear()
	user_input.edit()
