extends Control

@export var answers_grid: GridContainer
@export var quesiton_label: Label
@onready var deck: Deck = Global.data.activeDeck
const CORRECT_SCORE:int = 100
const INCORRECT_SCORE:int = 0
var activeCard:Card
var startTime:int
const MC_ANSWER_BUTTON = preload("uid://dqg8lbasw46rg")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	getQuestion()

func _on_back_button_pressed() -> void:
	SceneManager.changeSceneTo(SceneManager.EDIT_DECK)

func getQuestion():
	startTime = Time.get_ticks_msec()
	activeCard = deck.getCard()
	var answerOptions:Array[Card] = deck.getAnswerOptions(activeCard)
	quesiton_label.text = activeCard.question
	for answerButton:MC_Answer_Button in answers_grid.get_children():
		answerButton.queue_free()
	for answerCard:Card in answerOptions:
		var newAnswerButton:MC_Answer_Button = MC_ANSWER_BUTTON.instantiate()
		answers_grid.add_child(newAnswerButton)
		newAnswerButton.setData(answerCard.answer)
		newAnswerButton.on_answer.connect(_onUserAnswer)

func _onUserAnswer(userAnswer:String):
	if userAnswer == activeCard.answer:
		var answerTime = Time.get_ticks_msec()
		activeCard.onAnswer(CORRECT_SCORE, answerTime-startTime)
		print_debug("Correct")
		getQuestion()
	else:
		activeCard.onAnswer(INCORRECT_SCORE)
		print_debug("Incorrect")
