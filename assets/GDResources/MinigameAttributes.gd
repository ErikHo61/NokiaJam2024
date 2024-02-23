extends Resource
class_name MinigameAttributes

enum MinigameType {FOOD, MAINTENANCE}

@export var title: String = ""
@export var type: MinigameType = MinigameType.FOOD
@export var orders: Array[OrderAttributes] = []
@export var ingredients: Array = []
