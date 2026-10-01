extends Control

@export var _answers_grid: GridContainer
@export var _quesiton_label: Label
@onready var _deck: Deck = Global.data.activeDeck
const _CORRECT_SCORE:int = 100
const _INCORRECT_SCORE:int = 0
const _MIN_CARDS_COUNT:int = 5
var _activeCard:Card
var _startTime:int
const _MC_ANSWER_BUTTON = preload("uid://dqg8lbasw46rg")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	getQuestion()

func _on_back_button_pressed() -> void:
	SceneManager.changeSceneTo(SceneManager.EDIT_DECK)

func getQuestion():
	if _deck.cards.size() < _MIN_CARDS_COUNT:
		_quesiton_label.text = "The Deck needs at least %d cards to use this study mode" % _MIN_CARDS_COUNT
		printerr("Cards list is empty")
		return
	_startTime = Time.get_ticks_msec()
	_activeCard = _deck.getCard()
	var answerOptions:Array[Card] = _deck.getAnswerOptions(_activeCard)
	_quesiton_label.text = _activeCard.question
	for answerButton:MC_Answer_Button in _answers_grid.get_children():
		answerButton.queue_free()
	for answerCard:Card in answerOptions:
		var newAnswerButton:MC_Answer_Button = _MC_ANSWER_BUTTON.instantiate()
		_answers_grid.add_child(newAnswerButton)
		newAnswerButton.setData(answerCard.answer)
		newAnswerButton.on_answer.connect(_onUserAnswer)

func _onUserAnswer(userAnswer:String):
	if userAnswer == _activeCard.answer:
		var answerTime = Time.get_ticks_msec()
		_activeCard.onAnswer(_CORRECT_SCORE, answerTime-_startTime)
		print_debug("Correct")
		getQuestion()
	else:
		_activeCard.onAnswer(_INCORRECT_SCORE)
		print_debug("Incorrect")
