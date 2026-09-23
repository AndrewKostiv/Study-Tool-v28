class_name CardDisplay extends Control

signal removeCard(card:Card)
@onready var question: LineEdit = %Question
@onready var answer: LineEdit = %Answer
@onready var favor_button: Button = %Favor
@onready var delete_button: Button = %Delete
var updateIsFavoredButton: Callable = func():
	favor_button.text = "Is Favored" if card.isFavored else "Not Favored"
var card:Card

func setData(newCard:Card):
	card = newCard
	question.text = newCard.question
	answer.text = newCard.answer
	updateIsFavoredButton.call()

func _on_favor_pressed() -> void:
	card.isFavored = !card.isFavored
	updateIsFavoredButton.call()

func _on_delete_pressed() -> void:
	removeCard.emit(card)
	queue_free()

func _on_question_text_changed(new_text: String) -> void:
	card.question = new_text

func _on_answer_text_changed(new_text: String) -> void:
	card.answer = new_text
