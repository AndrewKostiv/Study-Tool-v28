extends Control

@onready var deck = Global.data.activeDeck
@export var study_mode_base: StudyModeBase
@export var user_input: LineEdit
@export var quesiton_label: Label
@export var answers_grid: GridContainer

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
	var answerOptions:Array[Card] = deck.getAnswerOptions(activeCard)
	for card in answers_grid.get_children():
		card.queue_free()
	for card:Card in answerOptions:
		var newLabel:Label = Label.new()
		answers_grid.add_child(newLabel)
		newLabel.text = card.answer
		newLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		newLabel.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		newLabel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		newLabel.size_flags_vertical = Control.SIZE_EXPAND_FILL

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
