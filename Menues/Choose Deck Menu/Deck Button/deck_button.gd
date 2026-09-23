class_name DeckButton extends Control

signal removeDeck(deck:Deck)
@export var deck:Deck
@onready var go_to_deck: Button = %GoToDeck

func setData(newDeck:Deck):
	deck = newDeck
	go_to_deck.text = deck.deckName

func _on_go_to_deck_pressed() -> void:
	Global.data.activeDeck = deck
	SceneManager.changeSceneTo(SceneManager.EDIT_DECK)

func _on_delete_deck_pressed() -> void:
	removeDeck.emit(deck)
	queue_free()
