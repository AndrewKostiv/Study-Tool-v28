class_name Deck extends Resource

# Deck Spacific vars
@export var deckName:String
@export var cards:Array[Card] = []
var isUsingFavored:bool = false
# card managing vars
const _ACTIVE_CARDS_MAX_SIZE: int = 5
const _FAST_CARD_COUNT:int = 2
const _ANSWER_OPTIONS_COUNT:int = 4
var _activeCards:Array[Card] = []
var _activeCardsSave:Array[Card] = []
var isKnown:Callable = func(a:Card): return a.getIsKnown()
var isUnKnown:Callable = func(a:Card): return !a.getIsKnown()
var sortDecendingTime:Callable = func(a:Card, b:Card): return a.getAverageTime() > b.getAverageTime()

func _init(newDeckName:String = "", newCards:Array[Card] = []) -> void:
	deckName = newDeckName
	cards = newCards

#func getCard() -> Card:
	#return cards.pick_random()

func getCard() -> Card:
	if cards.is_empty():
		printerr("Cards list is empty")
		return
	if _activeCards.is_empty():
		_setActiveCards()
	return _activeCards.pop_front()

func _setActiveCards():
	_activeCards.clear()

	if cards.size() <= _ACTIVE_CARDS_MAX_SIZE:
		# If cards is too small, loop through them until _activeCardsSave is full
		var i := 0
		while _activeCards.size() < _ACTIVE_CARDS_MAX_SIZE:
			_activeCards.append(cards[i % cards.size()])
			i += 1
		_activeCardsSave = _activeCards.duplicate()
		return

	var unknownCards: Array[Card] = cards.filter(isUnKnown)
	var knownCards: Array[Card] = cards.filter(isKnown)
	knownCards.sort_custom(sortDecendingTime)

	if unknownCards.is_empty():
		# add slow cards
		_activeCards.append_array(knownCards.slice(0,_ACTIVE_CARDS_MAX_SIZE-_FAST_CARD_COUNT))
		# randomly insert some fast cards
		var fastKnownCards:Array[Card] = knownCards.slice(_ACTIVE_CARDS_MAX_SIZE-_FAST_CARD_COUNT, knownCards.size())
		for i in _FAST_CARD_COUNT:
			var randActiveCardsIndex:int = randi_range(0, _activeCards.size())
			var randFastKnownCardsIndex:int = randi_range(0, fastKnownCards.size()-1)
			_activeCards.insert(randActiveCardsIndex, fastKnownCards.pop_at(randFastKnownCardsIndex))

	elif unknownCards.size() < _ACTIVE_CARDS_MAX_SIZE:
		# add all the unknown cards, then fill the rest with the slowest known cards
		_activeCards.append_array(unknownCards)
		_activeCards.append_array(knownCards.slice(0, (_ACTIVE_CARDS_MAX_SIZE - _activeCards.size())))

	else:
		# add all unknowns, with at least one known if possible
		_activeCards.append_array(unknownCards.slice(0, _ACTIVE_CARDS_MAX_SIZE))
		if !knownCards.is_empty():
			_activeCards[randi_range(0, _activeCards.size()-1)] = knownCards.pick_random()

	# save the full _activeCards for use in getAnswerOptions()
	_activeCardsSave = _activeCards.duplicate()
	assert(_activeCards.size() == _ACTIVE_CARDS_MAX_SIZE)

func getAnswerOptions(card:Card) -> Array[Card]:
	var answerOptions: Array[Card] = []
	var _activeCardsSaveCopy = _activeCardsSave.duplicate()
	_activeCardsSaveCopy.erase(card)
	for i in 3:
		var randIndex:int = randi_range(0, _activeCardsSaveCopy.size()-1)
		answerOptions.append(_activeCardsSaveCopy.pop_at(randIndex))
	answerOptions.append(card)
	answerOptions.shuffle()
	return answerOptions
