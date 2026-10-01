class_name Card extends Resource

@export var question:String
@export var answer:String
@export var isFavored:bool
@export var _timeArr:Array[int]
@export var _accuracyArr:Array[int]
@export var isKnown:bool:
	get(): return getIsKnown()
var _arrSize:int = 2
var _sum:Callable = func(a,b): return a+b
const MAX_ACCURACY: int = 100
const MIN_ACCURACY: int = 0

func _init(newQuesion:String = "", newAnswer:String = "", newIsFavored:bool = false) -> void:
	question = newQuesion
	answer = newAnswer
	isFavored = newIsFavored
	_timeArr.resize(_arrSize)
	_accuracyArr.resize(_arrSize)
	_timeArr.fill(0)
	_accuracyArr.fill(0)

func getAverageTime() -> float:
	if _timeArr.size() <= 0:
		return float("inf")
	return _timeArr.reduce(_sum) / _timeArr.size()

func getAverageAccuracy() -> int:
	if _accuracyArr.size() <= 0:
		return 0
	return int(_accuracyArr.reduce(_sum) / _accuracyArr.size())

func getIsKnown() -> bool:
	if getAverageAccuracy() >= MAX_ACCURACY:
		return true
	return false

func onAnswer(newAccuracy:int, newTime:int = -1) -> void:
	_accuracyArr.append(newAccuracy)
	while _accuracyArr.size() > _arrSize:
		_accuracyArr.pop_front()
	if newTime != -1:
		_timeArr.append(newTime)
		while _timeArr.size() > _arrSize:
			_timeArr.pop_front()
