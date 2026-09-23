class_name EditDeck extends Control

@onready var deck:Deck = Global.data.activeDeck
@onready var deck_name: LineEdit = %"Deck Name"
@onready var cards_container: VBoxContainer = %"Cards Container"
const CARD_DISPLAY = preload("res://Menues/Edit Deck Menu/Card Display/Card Display.tscn")

func _ready() -> void:
	deck_name.text = deck.deckName
	reDrawCards()

func _on_back_pressed() -> void:
	Global.saveData()
	SceneManager.changeSceneTo(SceneManager.DECKS_MENU)

func _on_deck_name_text_changed(new_text: String) -> void:
	deck.deckName = new_text

func _on_add_deck_pressed() -> void:
	deck.cards.append(Card.new())
	Global.saveData()
	reDrawCards()

func reDrawCards() -> void:
	for card:CardDisplay in cards_container.get_children():
		card.queue_free()
	for card:Card in deck.cards:
		var newCardDisplay:CardDisplay = CARD_DISPLAY.instantiate()
		cards_container.add_child(newCardDisplay)
		newCardDisplay.setData(card)
		newCardDisplay.removeCard.connect(removeCard)

func removeCard(cardToRemove:Card):
	deck.cards.erase(cardToRemove)
	Global.saveData()
	reDrawCards()
